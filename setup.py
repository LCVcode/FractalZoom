from distutils.core import setup, Extension
from Cython.Build import cythonize

ext = [Extension("fractal", ["fractal.pyx"]),
       Extension("color", ["color.pyx"]),
       Extension("zoomer", ["zoomer.pyx"]),
       Extension("image", ["image.pyx"])]

setup(ext_modules=cythonize(ext, annotate=True))
