from PIL import Image
cimport color

ctypedef double complex complex

cdef tuple to_tuple(color.color ref):
    return (ref.r, ref.g, ref.b)
    
cdef color.color get_color(int depth, int max_depth):
    '''
    Returns a color based upon iteration depth and max_depth
    '''
    cdef:
        color.color result
        int value
    value = 256 - (depth * 256 // max_depth)

    result.r = value
    result.g = value
    result.b = value

    return result

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
        complex z, c= -0.8 + 0.156j

        color.color value
        double real, imag, imag_step, real_step
        float real_lo, real_hi, imag_lo, imag_hi

    real_lo = -0.1
    real_hi =  0.1
    imag_lo = -0.1
    imag_hi =  0.1

    imag_step = (imag_hi - imag_lo) / h
    real_step = (real_hi - real_lo) / w

    for i in range(h):
        for j in range(w):
            z.real = real_lo + j * real_step
            z.imag = imag_lo + i * imag_step

            depth = dive(z, c, max_depth)
            value = get_color(depth, max_depth)

            pixels[i, j] = to_tuple(value)

    im.show()

def get_image(size):
    im = Image.new("RGB", size, "black")
    return im

def default():
    cdef:
        int height, width
        int i, depth_limit
        color.color c
        complex point, offset

    size = 4096 * 2
    height, width = size, size
    depth_limit = 256

    make_image(height, width, depth_limit)
