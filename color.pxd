ctypedef struct color:
    int r, g, b

cdef tuple to_tuple(color ref)

cdef color get_color(int depth, int max_depth)
