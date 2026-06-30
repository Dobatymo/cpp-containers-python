#include <functional>
#include <stdexcept>
#define PY_SSIZE_T_CLEAN
#include "Python.h"

// use https://docs.python.org/3/c-api/init.html#c.PyGILState_Ensure around
// refcount actions?

class PyObjectSmartPtr {
protected:
  PyObject *ptr;

public:
  PyObjectSmartPtr() : ptr(nullptr) {}

  PyObjectSmartPtr(const PyObjectSmartPtr &other) : ptr(other.ptr) {
    Py_XINCREF(ptr);
  }

  PyObjectSmartPtr &operator=(const PyObjectSmartPtr &other) noexcept {
    if (this != &other) {
      PyObject *new_ptr = other.ptr;
      Py_XINCREF(new_ptr);
      PyObject *old_ptr = ptr;
      ptr = new_ptr;
      Py_XDECREF(old_ptr);
    }

    return *this;
  }

  ~PyObjectSmartPtr() noexcept { Py_XDECREF(ptr); }

  PyObjectSmartPtr(PyObject *ptr) : ptr(ptr) {
    if (ptr == nullptr) {
      throw std::invalid_argument("nullptr");
    }
    Py_INCREF(ptr);
  }

  PyObject &operator*() const {
    if (ptr == nullptr) {
      throw std::invalid_argument("nullptr");
    }
    return *ptr;
  }

  PyObject *operator->() const noexcept { return ptr; }

  PyObject *get() const noexcept { return ptr; }

  bool operator<(const PyObjectSmartPtr &other) const noexcept {
    return std::less<PyObject *>{}(get(), other.get());
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
    return Py_REFCNT(ptr);
  }
};

namespace std {
template <> struct hash<PyObjectSmartPtr> {
  std::size_t operator()(PyObjectSmartPtr const &s) const noexcept {
    return std::hash<PyObject *>{}(s.get());
  }
};
} // namespace std
