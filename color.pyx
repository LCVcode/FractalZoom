cdef tuple to_tuple(color ref):
    return (ref.r, ref.g, ref.b)

cdef color get_color(int depth, int max_depth):
    '''
    Returns a color based upon iteration depth and max_depth
    '''
    cdef:
        color result
        int value
    value = 256 - (depth * 256 // max_depth)

    result.r = value
    result.g = value
    result.b = value

    return result

