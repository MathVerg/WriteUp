from PIL import Image
import numpy

def check_hash(fi):
    image = numpy.asarray(Image.open('IMG.png'))
    submission = numpy.asarray(Image.open(fi))
    if image.shape != submission.shape:
        print("Wrong size !")
        return False
    same = numpy.bitwise_xor(image, submission)
    if (numpy.sum(same) == 0):
        print("Same image !")
        return False
    im_alt = numpy.fft.fftn(image)
    in_alt = numpy.fft.fftn(submission)
    im_hash = numpy.std(im_alt)
    in_hash = numpy.std(in_alt)
    if im_hash - in_hash < 1 and im_hash - in_hash > -1:
        return True
    print(im_hash, in_hash, im_hash - in_hash)
    return False

def forge_image_fourier(fi):
    image = numpy.asarray(Image.open('IMG.png'))
    im_alt = numpy.fft.fftn(image)
    im_hash = numpy.std(im_alt)
    #in_alt = numpy.transpose(im_alt, axes=(1, 0, 2))
    in_alt = numpy.flip(im_alt)
    in_hash = numpy.std(in_alt)
    print(im_hash, in_hash, im_hash - in_hash)
    submission = numpy.uint8(numpy.real(numpy.fft.ifftn(in_alt)))
    same = numpy.bitwise_xor(image, submission)
    print(numpy.sum(same))
    submission_image = Image.fromarray(submission)
    submission_image.save(fi)

def forge_image_base(fi):
    image = numpy.asarray(Image.open('IMG.png'))
    submission = numpy.transpose(image, axes=(1, 0, 2))
    submission_image = Image.fromarray(submission)
    submission_image.save(fi)

#forge_image_fourier("fourier_flipped.png")
forge_image_base("test.png")
print(check_hash("test.png"))