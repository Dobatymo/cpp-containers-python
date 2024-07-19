import platform
import sys

from Cython.Build import cythonize
from setuptools import Extension, setup

machine = platform.machine().lower()
x86 = ("x86_64", "amd64", "i386", "x86", "i686")

if sys.platform.startswith("linux"):
    if machine in x86:
        cflags = ["-std=c++14", "-O2", "-mavx"]
    else:
        cflags = ["-std=c++14", "-O2"]
elif sys.platform == "win32":
    if machine in x86:
        cflags = ["/std:c++14", "/O2", "/arch:AVX"]
    else:
        cflags = ["/std:c++14", "/O2"]
elif sys.platform == "darwin":
    if machine in x86:
        cflags = ["-std=c++14", "-O2", "-mavx"]
    else:
        cflags = ["-std=c++14", "-O2"]
else:
    cflags = []

cy_extensions = [
    Extension(
        "cppcontainers.cppcontainers",
        ["cppcontainers/cppcontainers.pyx"],
        include_dirs=["include"],
        extra_compile_args=cflags,
        language="c++",
    ),
]

compiler_directives = {
    "boundscheck": False,
    "wraparound": False,
    "initializedcheck": False,
    "annotation_typing": True,
    "warn.undeclared": True,
    "warn.unused": True,
    "warn.unused_arg": True,
    "warn.unused_result": True,
}

setup(
    ext_modules=cythonize(cy_extensions, language_level=3, compiler_directives=compiler_directives),
)
