from distutils.core import setup, Extension
from Cython.Build import cythonize

ext = [Extension("fractal", ["fractal.pyx"]),]

setup(ext_modules=cythonize(ext, annotate=True))
