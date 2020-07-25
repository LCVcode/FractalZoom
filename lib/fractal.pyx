from PIL import Image
from numpy import arange

ctypedef double complex complex

cdef struct color:
    int r, g, b
    
cdef color get_color(int depth, int max_depth):
    cdef int value = 256 - (256 * depth) / max_depth
    cdef color result
    result.r = value
    result.g = value
    result.b = value
    return result

cdef tuple color_to_tuple(color value):
    return (value.r, value.g, value.g)

cdef int dive(complex z, complex c, int max_depth):
    '''
    Returns number of iterations before max_depth is reached or point escapes
    '''
    cdef int depth = 0, limit = 2
    while (depth < max_depth) and abs(z.real) < limit and abs(z.imag) < limit:
        z = z**2 + c
        depth += 1
    return depth

cdef void make_image(int h, int w, int max_depth):
    '''
    Makes the image of the fractal
    '''
    im = get_image((h, w))
    pixels = im.load()

    cdef:
        int depth, i, j
        complex z, c=-0.3+0.4j
        color value
        double real, imag, imag_step, real_step
        float real_lo, real_hi, imag_lo, imag_hi

    real_lo = -2.0
    real_hi =  2.0
    imag_lo = -2.0
    imag_hi =  2.0

    imag_step = (imag_hi - imag_lo) / h
    real_step = (real_hi - real_lo) / w

    #for i, imag in enumerate(arange(-2, 2, imag_step)):
        #for j, real in enumerate(arange(-2, 2, real_step)):
    for i in range(h):
        for j in range(w):
            z.real = -2 + j * real_step
            z.imag = -2 + i * imag_step

            depth = dive(z, c, max_depth)
            value = get_color(depth, max_depth)

            pixels[i, j] = color_to_tuple(value)

    im.show()

def get_image(size):
    im = Image.new("RGB", size, "black")
    return im

def default():
    cdef:
        int height, width
        int i, depth_limit
        color c
        complex point, offset

    height, width = 900, 900
    depth_limit = 125

    make_image(height, width, depth_limit)

