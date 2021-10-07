# distutils: language=c++

from cpython.ref cimport PyObject
from libcpp cimport bool as cbool


cdef extern from "smartptr.h":
	cdef cppclass PyObjectSmartPtr:

		PyObjectSmartPtr(PyObject *) except +
		PyObject *get() const
		ssize_t refcount() const
		cbool operator<(const PyObjectSmartPtr &) const
		cbool operator==(const PyObjectSmartPtr &) const
		cbool operator!=(const PyObjectSmartPtr &) const
