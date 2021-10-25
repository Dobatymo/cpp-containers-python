#include <stdexcept>
#define PY_SSIZE_T_CLEAN
#include "Python.h"

class PyObjectSmartPtr {
protected:
    PyObject *ptr;

public:
    PyObjectSmartPtr(): ptr(nullptr) {
    }

    PyObjectSmartPtr(const PyObjectSmartPtr &other) : ptr(other.ptr) {
        Py_XINCREF(ptr);
    }

    PyObjectSmartPtr &operator=(const PyObjectSmartPtr &other) noexcept {
        if (this != &other)
        {
            Py_XDECREF(ptr);
            ptr = other.ptr;
            Py_XINCREF(ptr);
        }

        return *this;
    }

    ~PyObjectSmartPtr() noexcept {
        Py_XDECREF(ptr);
    }

    PyObjectSmartPtr(PyObject *ptr): ptr(ptr) {
        if (ptr == nullptr) {
            throw std::invalid_argument("nullptr");
        }
        Py_INCREF(ptr);
    }

    PyObject& operator*() const {
        if (ptr == nullptr) {
            throw std::invalid_argument("nullptr");
        }
        return *ptr;
    }

    PyObject* operator->() const noexcept {
        return ptr;
    }

    PyObject *get() const noexcept {
        return ptr;
    }

    bool operator<(const PyObjectSmartPtr &other) const noexcept {
        return get() < other.get();
    }

    bool operator==(const PyObjectSmartPtr &other) const noexcept {
        return get() == other.get();
    }

    bool operator!=(const PyObjectSmartPtr &other) const noexcept {
        return get() != other.get();
    }

    Py_ssize_t refcount() const {
        if (ptr == nullptr) {
            throw std::invalid_argument("nullptr");
        }
        return ptr->ob_refcnt;
    }
};

namespace std
{
    template<> struct hash<PyObjectSmartPtr>
    {
        std::size_t operator()(PyObjectSmartPtr const& s) const noexcept
        {
            return std::hash<PyObject *>{}(s.get());
        }
    };
}
