cimport color
cimport fractal
from PIL import Image

cdef void make_image(int h, int w, int max_depth, str filename='temp'):
    '''
    Makes the image of the fractal
    '''
    im = Image.new("RGB", (h, w), "black")
    pixels = im.load()

    cdef:
        int depth, i, j
        complex z, c= -0.8 + 0.156j

        color.color value
        double real, imag, imag_step, real_step
        double real_lo, real_hi, imag_lo, imag_hi

    real_lo = -0.1
    real_hi =  0.1
    imag_lo = -0.1
    imag_hi =  0.1

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

    im.save('img/' + filename + '.png', format="PNG")

def default():
    cdef:
        int height, width
        int i, depth_limit
        color.color c
        complex point, offset

    size = 4096 // 2
    height, width = size, size
    depth_limit = 256

    make_image(height, width, depth_limit)
