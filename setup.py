import platform
import sys

from Cython.Build import cythonize
from setuptools import Extension, setup

machine = platform.machine().lower()
x86 = ("x86_64", "amd64", "i386", "x86", "i686")

if sys.platform.startswith("linux"):
    if machine in x86:
        cflags = ["-std=c++14", "-O2", "-mavx2"]
    else:
        cflags = ["-std=c++14", "-O2"]
elif sys.platform == "win32":
    if machine in x86:
        cflags = ["/std:c++14", "/O2", "/arch:AVX2"]
    else:
        cflags = ["/std:c++14", "/O2"]
elif sys.platform == "darwin":
    if machine in x86:
        cflags = ["-std=c++14", "-O2", "-mavx2"]
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

with open("README.md", "r", encoding="utf-8") as fr:
    long_description = fr.read()

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
    author="Dobatymo",
    name="cpp-containers",
    version="0.1",
    url="https://github.com/Dobatymo/cpp-containers-python",
    description="Python wrapper for CPP stdlib containers",
    long_description=long_description,
    long_description_content_type="text/markdown",
    packages=["cppcontainers"],
    ext_modules=cythonize(cy_extensions, language_level=3, compiler_directives=compiler_directives),
    python_requires=">=3.6",
    zip_safe=False,
)
