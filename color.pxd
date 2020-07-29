ctypedef struct color:
    int r, g, b

cdef tuple to_tuple(color ref)
