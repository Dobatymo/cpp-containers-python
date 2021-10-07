# cpp-containers-python

Python wrapper for the C++ Standard Library containers. The behaviour of the containers might not be as expected, since for sorting and hashing the items only the pointer to the Python object is used, and not the actual content. That means items in ordered collections will be ordered according to memory layout and to object content. Furhermore, equality checks will work as pairwise `is` tests, because only the pointers are compared internally. Also certain operations will lead to *undefined behavior*, such as accessing out of bounds indices in `Vector`.

This design decision was made for performance reasons and to keep the code as simple and close to C++ as possible. Real equality checks can still be implemented by pairwise comparison of the objects at Python level. This won't be any faster than doing so on normal Python collections.

For more documentation about the C++ containers see <https://en.cppreference.com/w/cpp/container>.

## Install
`pip install cpp-containers` (not working yet)
