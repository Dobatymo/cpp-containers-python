from typing import Any, Iterable, Tuple

from cpython.ref cimport PyObject
from cython.operator cimport dereference as deref
from cython.operator cimport preincrement as inc
from libcpp cimport bool as cbool
from libcpp.deque cimport deque
from libcpp.forward_list cimport forward_list
from libcpp.list cimport list
from libcpp.map cimport map
from libcpp.set cimport set
from libcpp.unordered_map cimport unordered_map
from libcpp.unordered_set cimport unordered_set
from libcpp.utility cimport pair
from libcpp.vector cimport vector

from .smartptr cimport PyObjectSmartPtr

ctypedef PyObject *c_value_t
ctypedef object p_value_t

ctypedef deque[PyObjectSmartPtr].iterator deque_it
ctypedef forward_list[PyObjectSmartPtr].iterator forward_list_it
ctypedef list[PyObjectSmartPtr].iterator list_it
ctypedef map[PyObjectSmartPtr, PyObjectSmartPtr].iterator map_it
ctypedef set[PyObjectSmartPtr].iterator set_it
ctypedef unordered_map[PyObjectSmartPtr, PyObjectSmartPtr].iterator unordered_map_it
ctypedef unordered_set[PyObjectSmartPtr].iterator unordered_set_it
ctypedef vector[PyObjectSmartPtr].iterator vector_it

cdef class DequeIterator:

	cdef deque_it it

	@staticmethod
	cdef create(deque_it it):
		iter = DequeIterator()
		iter.it = it
		return iter

	cpdef void next(self):
		inc(self.it)

	cpdef object deref(self):
		return <p_value_t>deref(self.it).get()

	def __eq__(self, DequeIterator other):
		return self.it == other.it

	def __neq__(self, DequeIterator other):
		return self.it != other.it

cdef class ForwardListIterator:

	cdef forward_list_it it

	@staticmethod
	cdef create(forward_list_it it):
		iter = ForwardListIterator()
		iter.it = it
		return iter

	cpdef void next(self):
		inc(self.it)

	cpdef object deref(self):
		return <p_value_t>deref(self.it).get()

	def __eq__(self, ForwardListIterator other):
		return self.it == other.it


cdef class ListIterator:

	cdef list_it it

	@staticmethod
	cdef create(list_it it):
		iter = ListIterator()
		iter.it = it
		return iter

	cpdef void next(self):
		inc(self.it)

	cpdef object deref(self):
		return <p_value_t>deref(self.it).get()

	def __eq__(self, ListIterator other):
		return self.it == other.it


cdef class MapIterator:

	cdef map_it it

	@staticmethod
	cdef create(map_it it):
		iter = MapIterator()
		iter.it = it
		return iter

	cpdef void next(self):
		inc(self.it)

	cpdef object deref(self):
		cdef pair[PyObjectSmartPtr, PyObjectSmartPtr] result = deref(self.it)
		return (<p_value_t>result.first.get(), <p_value_t>result.second.get())

	def __eq__(self, MapIterator other):
		return self.it == other.it


cdef class SetIterator:

	cdef set_it it

	@staticmethod
	cdef create(set_it it):
		iter = SetIterator()
		iter.it = it
		return iter

	cpdef void next(self):
		inc(self.it)

	cpdef object deref(self):
		return <p_value_t>deref(self.it).get()

	def __eq__(self, SetIterator other):
		return self.it == other.it


cdef class UnorderedMapIterator:

	cdef unordered_map_it it

	@staticmethod
	cdef create(unordered_map_it it):
		iter = UnorderedMapIterator()
		iter.it = it
		return iter

	cpdef void next(self):
		inc(self.it)

	cpdef object deref(self):
		cdef pair[PyObjectSmartPtr, PyObjectSmartPtr] result = deref(self.it)
		return (<p_value_t>result.first.get(), <p_value_t>result.second.get())

	def __eq__(self, UnorderedMapIterator other):
		return self.it == other.it


cdef class UnorderedSetIterator:

	cdef unordered_set_it it

	@staticmethod
	cdef create(unordered_set_it it):
		iter = UnorderedSetIterator()
		iter.it = it
		return iter

	cpdef void next(self):
		inc(self.it)

	cpdef object deref(self):
		return <p_value_t>deref(self.it).get()

	def __eq__(self, UnorderedSetIterator other):
		return self.it == other.it


cdef class VectorIterator:

	cdef vector_it it

	@staticmethod
	cdef create(vector_it it):
		iter = VectorIterator()
		iter.it = it
		return iter

	cpdef void next(self):
		inc(self.it)

	cpdef object deref(self):
		return <p_value_t>deref(self.it).get()

	def __eq__(self, VectorIterator other):
		return self.it == other.it


cdef class Deque:

	cdef deque[PyObjectSmartPtr] deque

	def __init__(self):
		pass

	# Element access

	cpdef object at(self, size_t pos):
		return <p_value_t>self.deque.at(pos).get()

	def __getitem__(self, size_t pos) -> object:
		return <p_value_t>self.deque[pos].get()

	def __setitem__(self, size_t pos, object value) -> void:
		self.deque[pos] = PyObjectSmartPtr(<c_value_t>value)

	cpdef object front(self):
		return <p_value_t>self.deque.front().get()

	cpdef object back(self):
		return <p_value_t>self.deque.back().get()

	# Iterators

	cpdef DequeIterator begin(self):
		return DequeIterator.create(self.deque.begin())

	cpdef DequeIterator end(self):
		return DequeIterator.create(self.deque.end())

	def __iter__(self):
		cdef deque[PyObjectSmartPtr].iterator it = self.deque.begin()
		while it != self.deque.end():
			yield <p_value_t>deref(it).get()
			inc(it)

	# Capacity

	cpdef cbool empty(self):
		return self.deque.empty()

	cpdef size_t size(self):
		return self.deque.size()

	cpdef size_t max_size(self):
		return self.deque.max_size()

	cpdef void shrink_to_fit(self):
		self.deque.shrink_to_fit()

	# Modifiers

	cpdef void clear(self):
		self.deque.clear()

	cpdef void push_back(self, object value):
		self.deque.push_back(PyObjectSmartPtr(<c_value_t>value))

	cpdef void pop_back(self):
		self.deque.pop_back()

	cpdef void push_front(self, object value):
		self.deque.push_front(PyObjectSmartPtr(<c_value_t>value))

	cpdef void pop_front(self):
		self.deque.pop_front()

	cpdef void resize(self, size_t count, object value):
		self.deque.resize(count, PyObjectSmartPtr(<c_value_t>value))

	cpdef void swap(self, Deque other):
		self.deque.swap(other.deque)

	# Non-member functions

	def __eq__(self, Deque other) -> bool:
		return self.deque == other.deque

	# Convenience

	def update(self, values: Iterable) -> None:
		for value in values:
			self.deque.push_back(PyObjectSmartPtr(<c_value_t>value))

cdef class ForwardList:

	cdef forward_list[PyObjectSmartPtr] list

	def __init__(self):
		pass

	# Element access

	cpdef object front(self):
		return <p_value_t>self.list.front().get()

	# Iterators

	cpdef ForwardListIterator begin(self):
		return ForwardListIterator.create(self.list.begin())

	cpdef ForwardListIterator end(self):
		return ForwardListIterator.create(self.list.end())

	def __iter__(self):
		cdef forward_list[PyObjectSmartPtr].iterator it = self.list.begin()
		while it != self.list.end():
			yield <p_value_t>deref(it).get()
			inc(it)

	# Capacity

	cpdef cbool empty(self):
		return self.list.empty()

	cpdef size_t max_size(self):
		return self.list.max_size()

	# Modifiers

	cpdef void clear(self):
		self.list.clear()

	cpdef void push_front(self, object value):
		self.list.push_front(PyObjectSmartPtr(<c_value_t>value))

	cpdef void pop_front(self):
		self.list.pop_front()

	cpdef void resize(self, size_t count, object value):
		self.list.resize(count, PyObjectSmartPtr(<c_value_t>value))

	cpdef void swap(self, ForwardList other):
		self.list.swap(other.list)

	# Operations

	cpdef void merge(self, ForwardList other):
		self.list.merge(other.list)

	cpdef void remove(self, object value):
		self.list.remove(PyObjectSmartPtr(<c_value_t>value))

	cpdef void reverse(self):
		self.list.reverse()

	cpdef void unique(self):
		self.list.unique()

	cpdef void sort(self):
		self.list.sort()

	# Non-member functions

	def __eq__(self, ForwardList other) -> bool:
		return self.list == other.list

	# Convenience

	def update(self, values: Iterable) -> None:
		for value in values:
			self.list.push_front(PyObjectSmartPtr(<c_value_t>value))

cdef class List:

	cdef list[PyObjectSmartPtr] list

	def __init__(self):
		pass

	# Element access

	cpdef object front(self):
		return <p_value_t>self.list.front().get()

	cpdef object back(self):
		return <p_value_t>self.list.back().get()

	# Iterators

	cpdef ListIterator begin(self):
		return ListIterator.create(self.list.begin())

	cpdef ListIterator end(self):
		return ListIterator.create(self.list.end())

	def __iter__(self):
		cdef list[PyObjectSmartPtr].iterator it = self.list.begin()
		while it != self.list.end():
			yield <p_value_t>deref(it).get()
			inc(it)

	# Capacity

	cpdef cbool empty(self):
		return self.list.empty()

	cpdef size_t size(self):
		return self.list.size()

	cpdef size_t max_size(self):
		return self.list.max_size()

	# Modifiers

	cpdef void clear(self):
		self.list.clear()

	cpdef void push_back(self, object value):
		self.list.push_back(PyObjectSmartPtr(<c_value_t>value))

	cpdef void pop_back(self):
		self.list.pop_back()

	cpdef void push_front(self, object value):
		self.list.push_front(PyObjectSmartPtr(<c_value_t>value))

	cpdef void pop_front(self):
		self.list.pop_front()

	cpdef void resize(self, size_t count, object value):
		self.list.resize(count, PyObjectSmartPtr(<c_value_t>value))

	cpdef void swap(self, List other):
		self.list.swap(other.list)

	# Operations

	cpdef void merge(self, List other):
		self.list.merge(other.list)

	cpdef void remove(self, object value):
		self.list.remove(PyObjectSmartPtr(<c_value_t>value))

	cpdef void reverse(self):
		self.list.reverse()

	cpdef void unique(self):
		self.list.unique()

	cpdef void sort(self):
		self.list.sort()

	# Non-member functions

	def __eq__(self, List other) -> bool:
		return self.list == other.list

	# Convenience

	def update(self, values: Iterable) -> None:
		for value in values:
			self.list.push_back(PyObjectSmartPtr(<c_value_t>value))

cdef class Map:

	cdef map[PyObjectSmartPtr, PyObjectSmartPtr] map

	def __init__(self):
		pass

	# Element access

	cpdef object at(self, object key):
		return <p_value_t>self.map.at(PyObjectSmartPtr(<c_value_t>key)).get()

	def __getitem__(self, object key) -> object:
		# should this default contruct an object?

		return <p_value_t>self.map.at(PyObjectSmartPtr(<c_value_t>key)).get()

	def __setitem__(self, object key, object value) -> None:
		self.map[PyObjectSmartPtr(<c_value_t>key)] = PyObjectSmartPtr(<c_value_t>value)

	# Iterators

	cpdef MapIterator begin(self):
		return MapIterator.create(self.map.begin())

	cpdef MapIterator end(self):
		return MapIterator.create(self.map.end())

	def keys(self):
		cdef map[PyObjectSmartPtr, PyObjectSmartPtr].iterator it = self.map.begin()
		cdef pair[PyObjectSmartPtr, PyObjectSmartPtr] result
		while it != self.map.end():
			result = deref(it)
			yield <p_value_t>result.first.get()
			inc(it)

	def values(self):
		cdef map[PyObjectSmartPtr, PyObjectSmartPtr].iterator it = self.map.begin()
		cdef pair[PyObjectSmartPtr, PyObjectSmartPtr] result
		while it != self.map.end():
			result = deref(it)
			yield <p_value_t>result.second.get()
			inc(it)

	def items(self):
		cdef map[PyObjectSmartPtr, PyObjectSmartPtr].iterator it = self.map.begin()
		cdef pair[PyObjectSmartPtr, PyObjectSmartPtr] result
		while it != self.map.end():
			result = deref(it)
			yield (<p_value_t>result.first.get(), <p_value_t>result.second.get())
			inc(it)

	def __iter__(self):
		return self.keys()

	# Capacity

	cpdef cbool empty(self):
		return self.map.empty()

	cpdef size_t size(self):
		return self.map.size()

	cpdef size_t max_size(self):
		return self.map.max_size()

	# Modifiers

	cpdef void clear(self):
		self.map.clear()

	cpdef cbool insert(self, object key, object value):

		cdef pair[PyObjectSmartPtr, PyObjectSmartPtr] item = pair[PyObjectSmartPtr, PyObjectSmartPtr](PyObjectSmartPtr(<c_value_t>key), PyObjectSmartPtr(<c_value_t>value))
		cdef pair[map[PyObjectSmartPtr, PyObjectSmartPtr].iterator, cbool] result = self.map.insert(item)
		return result.second

	# Lookup

	cpdef size_t count(self, object key):
		cdef size_t result = self.map.count(PyObjectSmartPtr(<c_value_t>key))

		return result

	cpdef object find(self, object key):
		cdef map[PyObjectSmartPtr, PyObjectSmartPtr].iterator it = self.map.find(PyObjectSmartPtr(<c_value_t>key))

		if it != self.map.end():
			return <p_value_t>deref(it).second.get()
		else:
			raise KeyError(key)

	""" C++ 20
	cpdef cbool contains(self, object key):
		return self.map.contains(PyObjectSmartPtr(<c_value_t>key))
	"""

	# Non-member functions

	def __eq__(self, Map other) -> bool:
		return self.map == other.map

	# Convenience

	def update(self, it: Iterable[Tuple[Any, Any]]) -> None:
		for k, v in it:
			self.map[PyObjectSmartPtr(<c_value_t>k)] = PyObjectSmartPtr(<c_value_t>v)

cdef class Set:

	cdef set[PyObjectSmartPtr] set

	def __init__(self):
		pass

	# Iterators

	cpdef SetIterator begin(self):
		return SetIterator.create(self.set.begin())

	cpdef SetIterator end(self):
		return SetIterator.create(self.set.end())

	def __iter__(self):
		cdef set[PyObjectSmartPtr].iterator it = self.set.begin()
		while it != self.set.end():
			yield <p_value_t>deref(it).get()
			inc(it)

	# Capacity

	cpdef cbool empty(self):
		return self.set.empty()

	cpdef size_t size(self):
		return self.set.size()

	cpdef size_t max_size(self):
		return self.set.max_size()

	# Modifiers

	cpdef void clear(self):
		self.set.clear()

	cpdef cbool insert(self, object value):
		cdef pair[set[PyObjectSmartPtr].iterator, cbool] result = self.set.insert(PyObjectSmartPtr(<c_value_t>value))

		return result.second

	cpdef void swap(self, Set other):
		self.set.swap(other.set)

	""" C++ 17
	cpdef void merge(self, Set source):
		self.set.merge(source.set)
	"""

	# Lookup

	cpdef size_t count(self, object value):
		cdef size_t result = self.set.count(PyObjectSmartPtr(<c_value_t>value))

		return result

	cpdef object find(self, object value):
		cdef set[PyObjectSmartPtr].iterator it = self.set.find(PyObjectSmartPtr(<c_value_t>value))

		if it != self.set.end():
			return <p_value_t>deref(it).get()
		else:
			raise KeyError(value)

	# Non-member functions

	def __eq__(self, Set other) -> bool:
		return self.set == other.set

	# Convenience

	def update(self, it: Iterable[Any]) -> None:
		for value in it:
			self.set.insert(PyObjectSmartPtr(<c_value_t>value))

cdef class UnorderedMap:

	cdef unordered_map[PyObjectSmartPtr, PyObjectSmartPtr] map

	def __init__(self):
		pass

	# Element access

	cpdef object at(self, object key):
		return <p_value_t>self.map.at(PyObjectSmartPtr(<c_value_t>key)).get()

	def __getitem__(self, object key) -> object:
		# should this default contruct an object?

		return <p_value_t>self.map.at(PyObjectSmartPtr(<c_value_t>key)).get()

	def __setitem__(self, object key, object value) -> None:
		self.map[PyObjectSmartPtr(<c_value_t>key)] = PyObjectSmartPtr(<c_value_t>value)

	# Iterators

	cpdef UnorderedMapIterator begin(self):
		return UnorderedMapIterator.create(self.map.begin())

	cpdef UnorderedMapIterator end(self):
		return UnorderedMapIterator.create(self.map.end())

	def keys(self):
		cdef unordered_map[PyObjectSmartPtr, PyObjectSmartPtr].iterator it = self.map.begin()
		cdef pair[PyObjectSmartPtr, PyObjectSmartPtr] result
		while it != self.map.end():
			result = deref(it)
			yield <p_value_t>result.first.get()
			inc(it)

	def values(self):
		cdef unordered_map[PyObjectSmartPtr, PyObjectSmartPtr].iterator it = self.map.begin()
		cdef pair[PyObjectSmartPtr, PyObjectSmartPtr] result
		while it != self.map.end():
			result = deref(it)
			yield <p_value_t>result.second.get()
			inc(it)

	def items(self):
		cdef unordered_map[PyObjectSmartPtr, PyObjectSmartPtr].iterator it = self.map.begin()
		cdef pair[PyObjectSmartPtr, PyObjectSmartPtr] result
		while it != self.map.end():
			result = deref(it)
			yield (<p_value_t>result.first.get(), <p_value_t>result.second.get())
			inc(it)

	def __iter__(self):
		return self.keys()

	# Capacity

	cpdef cbool empty(self):
		return self.map.empty()

	cpdef size_t size(self):
		return self.map.size()

	cpdef size_t max_size(self):
		return self.map.max_size()

	# Modifiers

	cpdef void clear(self):
		self.map.clear()

	cpdef cbool insert(self, object key, object value):

		cdef pair[PyObjectSmartPtr, PyObjectSmartPtr] item = pair[PyObjectSmartPtr, PyObjectSmartPtr](PyObjectSmartPtr(<c_value_t>key), PyObjectSmartPtr(<c_value_t>value))
		cdef pair[unordered_map[PyObjectSmartPtr, PyObjectSmartPtr].iterator, cbool] result = self.map.insert(item)
		return result.second

	# Lookup

	cpdef size_t count(self, object key):
		cdef size_t result = self.map.count(PyObjectSmartPtr(<c_value_t>key))

		return result

	cpdef object find(self, object key):
		cdef unordered_map[PyObjectSmartPtr, PyObjectSmartPtr].iterator it = self.map.find(PyObjectSmartPtr(<c_value_t>key))

		if it != self.map.end():
			return <p_value_t>deref(it).second.get()
		else:
			raise KeyError(key)

	""" C++ 20
	cpdef cbool contains(self, object key):
		return self.map.contains(PyObjectSmartPtr(<c_value_t>key))
	"""

	# Convenience

	def update(self, it: Iterable[Tuple[Any, Any]]) -> None:
		for k, v in it:
			self.map[PyObjectSmartPtr(<c_value_t>k)] = PyObjectSmartPtr(<c_value_t>v)

cdef class UnorderedSet:

	cdef unordered_set[PyObjectSmartPtr] set

	def __init__(self):
		pass

	# Iterators

	cpdef UnorderedSetIterator begin(self):
		return UnorderedSetIterator.create(self.set.begin())

	cpdef UnorderedSetIterator end(self):
		return UnorderedSetIterator.create(self.set.end())

	def __iter__(self):
		cdef unordered_set_it it = self.set.begin()
		while it != self.set.end():
			yield <p_value_t>deref(it).get()
			inc(it)

	# Capacity

	cpdef cbool empty(self):
		return self.set.empty()

	cpdef size_t size(self):
		return self.set.size()

	cpdef size_t max_size(self):
		return self.set.max_size()

	# Modifiers

	cpdef void clear(self):
		self.set.clear()

	cpdef cbool insert(self, object value):
		cdef pair[unordered_set[PyObjectSmartPtr].iterator, cbool] result = self.set.insert(PyObjectSmartPtr(<c_value_t>value))

		return result.second

	cpdef void swap(self, UnorderedSet other):
		self.set.swap(other.set)

	""" C++ 17
	cpdef void merge(self, UnorderedSet source):
		self.set.merge(source.set)
	"""

	# Lookup

	cpdef size_t count(self, object key):
		cdef size_t result = self.set.count(PyObjectSmartPtr(<c_value_t>key))

		return result

	cpdef object find(self, object key):
		cdef unordered_set_it it = self.set.find(PyObjectSmartPtr(<c_value_t>key))

		if it != self.set.end():
			return <p_value_t>deref(it).get()
		else:
			raise KeyError(key)

	cpdef equal_range(self, object key):
		cdef pair[unordered_set_it, unordered_set_it] result = self.set.equal_range(PyObjectSmartPtr(<c_value_t>key))

		return (UnorderedSetIterator.create(result.first), UnorderedSetIterator.create(result.second))

	# Convenience

	def update(self, it: Iterable[Any]) -> None:
		for value in it:
			self.set.insert(PyObjectSmartPtr(<c_value_t>value))

cdef class Vector:

	cdef vector[PyObjectSmartPtr] vector

	def __init__(self):
		pass

	# Element access

	cpdef object at(self, size_t pos):
		return <p_value_t>self.vector.at(pos).get()

	def __getitem__(self, size_t pos) -> object:
		return <p_value_t>self.vector[pos].get()

	def __setitem__(self, size_t pos, object value) -> void:
		self.vector[pos] = PyObjectSmartPtr(<c_value_t>value)

	cpdef object front(self):
		return <p_value_t>self.vector.front().get()

	cpdef object back(self):
		return <p_value_t>self.vector.back().get()

	# cpdef data(self)

	# Iterators

	cpdef VectorIterator begin(self):
		return VectorIterator.create(self.vector.begin())

	cpdef VectorIterator end(self):
		return VectorIterator.create(self.vector.end())

	def __iter__(self):
		cdef vector[PyObjectSmartPtr].iterator it = self.vector.begin()
		while it != self.vector.end():
			yield <p_value_t>deref(it).get()
			inc(it)

	# Capacity

	cpdef cbool empty(self):
		return self.vector.empty()

	cpdef size_t size(self):
		return self.vector.size()

	cpdef size_t max_size(self):
		return self.vector.max_size()

	cpdef void reserve(self, size_t new_cap):
		self.vector.reserve(new_cap)

	cpdef size_t capacity(self):
		return self.vector.capacity()

	cpdef void shrink_to_fit(self):
		self.vector.shrink_to_fit()

	# Modifiers

	cpdef void clear(self):
		self.vector.clear()

	# cpdef insert()
	# cpdef emplace()
	# cpdef erase()

	cpdef void push_back(self, object value):
		self.vector.push_back(PyObjectSmartPtr(<c_value_t>value))

	# cpdef emplace_back()

	cpdef void pop_back(self):
		self.vector.pop_back()

	cpdef void resize(self, size_t count):
		self.vector.resize(count)

	def __eq__(self, Vector other) -> bool:
		return self.vector == other.vector

	# Convenience

	def update(self, it: Iterable[Any]) -> None:
		for value in it:
			self.vector.push_back(PyObjectSmartPtr(<c_value_t>value))
