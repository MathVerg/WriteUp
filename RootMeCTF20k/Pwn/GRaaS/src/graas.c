//statically linked against https://sourceforge.net/p/giflib/code/ci/5.2.2/tree/
//there shouldn't be any vuln in the library
#include "gif_lib.h"
#include <stdbool.h>
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <seccomp.h>

char *graas = "  _____                  _____ _\n"
              " / ____|                / ____| |\n"
              "| |  __ _ __ __ _  __ _| (___ | |\n"
              "| | |_ | '__/ _` |/ _` |\\___ \\| |\n"
              "| |__| | | | (_| | (_| |____) |_|\n"
              " \\_____|_|  \\__,_|\\__,_|_____/(_)\n";

#define MAX_FRAME_SIZE 128*128

void rotate_frame(GifFileType* dest, GifFileType* src, int i){
    char raster[MAX_FRAME_SIZE];
    int width = src->SavedImages[i].ImageDesc.Width;
    int height = src->SavedImages[i].ImageDesc.Height;
    SavedImage frame;
    frame.ImageDesc.Left = src->SavedImages[i].ImageDesc.Left;
    frame.ImageDesc.Top = src->SavedImages[i].ImageDesc.Top;
    frame.ImageDesc.Width = height;
    frame.ImageDesc.Height = width;
    frame.ImageDesc.Interlace = src->SavedImages[i].ImageDesc.Interlace;
    frame.ImageDesc.ColorMap = src->SavedImages[i].ImageDesc.ColorMap;
    frame.RasterBits = (GifByteType *)raster;
    frame.ExtensionBlockCount = src->SavedImages[i].ExtensionBlockCount;
    frame.ExtensionBlocks = src->SavedImages[i].ExtensionBlocks;

    // Copy rotated in the new frame
    for (int x = 0; x < height; x++) {
      for (int y = 0; y < width; y++) {
        frame.RasterBits[height * y + (height - x - 1)] =
            src->SavedImages[i].RasterBits[width * x + y];
      }
    }
    GifMakeSavedImage(dest, &frame);
}

// rotates the image and stores it to output file
int rotate(GifFileType *old, char *name) {
  int error;
  GifFileType *result = EGifOpenFileName(name, false, &error);

  if (!result) {
    fprintf(stderr, "\x1b[31mOpening output file failed\n\x1b[0m");
    return 1;
  }

  result->SWidth = old->SHeight;
  result->SHeight = old->SWidth;
  result->SColorResolution = old->SColorResolution;
  result->SBackGroundColor = old->SBackGroundColor;

  // If a Colormap exists, we copy it
  if (old->SColorMap) {
    result->SColorMap =
        GifMakeMapObject(old->SColorMap->ColorCount, old->SColorMap->Colors);
  } else {
    result->SColorMap = NULL;
  }

  size_t size = old->SavedImages[0].ImageDesc.Width * old->SavedImages[0].ImageDesc.Height;
  if (size > MAX_FRAME_SIZE) {
    fprintf(stderr, "\x1b[31mFrame size too big: %lu\n\x1b[0m", size);
    EGifCloseFile(result, &error); // Let's ignore errors while closing
    return 1;
  }

  for (int i = 0; i < old->ImageCount; i++) {
    rotate_frame(result, old, i);
  }

  // Writes the content to the file, deallocates memory and closes it
  if (EGifSpew(result) == GIF_ERROR) {
    fprintf(stderr, "\x1b[31mFailed to write to file\n\x1b[0m");
    EGifCloseFile(result, &error); // Let's ignore errors while closing
    return 1;
  }

  return 0;
}

int main(int argc, char *argv[]) {

  alarm(120);

  scmp_filter_ctx ctx;
  ctx = seccomp_init(SCMP_ACT_KILL_PROCESS);
  if (ctx == NULL) {
    perror("seccomp_init failed");
    _exit(1);
  }
  if (seccomp_rule_add(ctx, SCMP_ACT_ALLOW, SCMP_SYS(open), 0) < 0 ||
      seccomp_rule_add(ctx, SCMP_ACT_ALLOW, SCMP_SYS(openat), 0) < 0 ||
      seccomp_rule_add(ctx, SCMP_ACT_ALLOW, SCMP_SYS(read), 0) < 0 ||
      seccomp_rule_add(ctx, SCMP_ACT_ALLOW, SCMP_SYS(write), 0) < 0 ||
      seccomp_rule_add(ctx, SCMP_ACT_ALLOW, SCMP_SYS(close), 0) < 0 ||
      seccomp_rule_add(ctx, SCMP_ACT_ALLOW, SCMP_SYS(fcntl), 0) < 0 ||
      seccomp_rule_add(ctx, SCMP_ACT_ALLOW, SCMP_SYS(fstat), 0) < 0 ||
      seccomp_rule_add(ctx, SCMP_ACT_ALLOW, SCMP_SYS(brk), 0) < 0 ||
      seccomp_rule_add(ctx, SCMP_ACT_ALLOW, SCMP_SYS(exit), 0) < 0  ||
      seccomp_rule_add(ctx, SCMP_ACT_ALLOW, SCMP_SYS(exit_group), 0) < 0 )  {
    perror("seccomp_rule_add failed");
    seccomp_release(ctx);
    _exit(EXIT_FAILURE);
  }
  if (seccomp_load(ctx) < 0) {
    perror("seccomp_load failed");
    seccomp_release(ctx);
    _exit(EXIT_FAILURE);
  }
  seccomp_release(ctx);

  char *input_file;
  char *output_file;

  printf("Welcome to\n\x1b[33m%s\n\x1b[0m", graas);
  puts("\n");

  if (argc != 3) {
    fprintf(stderr, "Usage: %s <input.gif> <output.gif>\n", argv[0]);
    _exit(1);
  }

  input_file = argv[1];
  output_file = argv[2];

  // Used to read errors
  int error;

  // Open the file for read and write
  GifFileType *file;
  if ((file = DGifOpenFileName(input_file, &error)) == NULL) {
    fprintf(stderr, "\x1b[31mFailed to open %s: %s\n\x1b[0m", argv[1],
            GifErrorString(error));
    _exit(1);
  }

  // Read the rest of the file
  if (GIF_ERROR == DGifSlurp(file)) {
    fprintf(stderr, "\x1b[31mFailed to read the rest of %s: %s\n\x1b[0m",
            argv[1], GifErrorString(file->Error));
    _exit(1);
  }

  // Print some information about the gif
  printf("Canvas size:\t\t%d * %d\n", file->SWidth, file->SHeight);
  printf("Color resolution:\t%d\n", file->SColorResolution);
  printf("Background color:\t%d\n", file->SBackGroundColor);
  printf("Aspect Type:\t\t%d\n", file->AspectByte);
  printf("Image count:\t\t%d\n", file->ImageCount);

  if (rotate(file, output_file)) {
    fprintf(stderr, "\x1b[31mException while rotating %s\n\x1b[0m", input_file);
    _exit(1);
  }

  if (GIF_ERROR == DGifCloseFile(file, &error)) {
    fprintf(stderr, "\x1b[31mFailed to close %s: %s\n\x1b[0m", input_file,
            GifErrorString(error));
    _exit(1);
  }

  printf("Success ! You'll find your rotated GIF here: %s\n", output_file);

  printf("Thanks for using GraaS!\n");
  return 0;
}
