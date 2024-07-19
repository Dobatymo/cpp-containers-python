# cpp-containers-python

Python wrapper for the C++ Standard Library containers. The behavior of the containers might not be as expected, since for sorting and hashing the items, only the pointer to the Python object is used, and not the actual content. That means items in ordered collections will be ordered according to memory layout and not object content. Furthermore, equality checks will work as pairwise `is` tests, because only the pointers are compared internally. Also certain operations will lead to *undefined behavior*, such as accessing out of bounds indices in `Vector`.

This design decision was made for performance reasons and to keep the code as simple and close to C++ as possible. Real equality checks can still be implemented by pairwise comparison of the objects at Python level. This won't be any faster than doing so on normal Python collections.

For more documentation about the C++ containers see <https://en.cppreference.com/w/cpp/container>.

## Requirements
Python 3.7+.

## Install
`pip install cpp-containers`

## Examples
```
from cppcontainers import MultiSet
s = MultiSet()
s.insert(1)
s.insert(2)
s.insert(2)
assert list(s) == [1, 2, 2]
assert s.size() == 3
assert s.count(2) == 2
assert s.begin().deref() == 1
```

The containers store references to Python objects, not copies.

```
from cppcontainers import Vector
from sys import getrefcount
v = Vector()
a = "asd"
b = [1, 2, 3]
v.push_back(a)
v.push_back(b)
assert id(a) == id(v[0])
assert list(v) == [a, b]
b.append(4)
assert b[-1] == v[1][-1]
assert getrefcount(a) == 3
del v
assert getrefcount(a) == 2
```

The following crashes, just like in C++.

```
from cppcontainers import Vector
Vector()[0]
```

And this throws an exception like in C++.

```
from cppcontainers import Vector
Vector().at(0)
```
