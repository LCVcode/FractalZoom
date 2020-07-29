cimport color

cdef int dive(complex z, complex c, int max_depth):
    '''
    Returns number of iterations before max_depth is reached or point escapes
    '''
    cdef int depth = 0, limit = 2
    while (depth < max_depth) and abs(z.real) < limit and abs(z.imag) < limit:
        z = z**2 + c
        depth += 1
    return depth

