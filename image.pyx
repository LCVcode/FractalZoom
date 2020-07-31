cimport color
cimport fractal
from PIL import Image

cpdef bint make_image(int h, int w, int max_depth, str filename, complex c, double real_lo, double imag_lo, double real_hi, double imag_hi):
    '''
    Makes the image of the fractal
    '''
    im = Image.new("RGB", (h, w), "black")
    pixels = im.load()

    cdef:
        int depth, i, j
        complex z

        color.color value
        double real, imag, imag_step, real_step

    imag_step = (imag_hi - imag_lo)
    imag_step /= h
    real_step = (real_hi - real_lo)
    real_step /= w

    for i in range(h):
        for j in range(w):
            z.real = real_lo + j * real_step
            z.imag = imag_lo + i * imag_step

            depth = fractal.dive(z, c, max_depth)
            value = color.get_color(depth, max_depth)

            pixels[i, j] = color.to_tuple(value)

    im.save('img/' + filename, format="PNG")

    return True
