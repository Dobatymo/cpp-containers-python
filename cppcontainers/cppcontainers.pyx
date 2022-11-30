from typing import Any, Iterable, Tuple

from cpython.ref cimport PyObject
from cython.operator cimport dereference as deref
from cython.operator cimport predecrement as dec
from cython.operator cimport preincrement as inc
from libcpp.deque cimport deque
from libcpp.forward_list cimport forward_list
from libcpp.list cimport list
from libcpp.map cimport map, multimap
from libcpp.set cimport multiset, set
from libcpp.unordered_map cimport unordered_map, unordered_multimap
from libcpp.unordered_set cimport unordered_multiset, unordered_set
from libcpp.utility cimport pair
from libcpp.vector cimport vector

from .smartptr cimport PyObjectSmartPtr

ctypedef PyObject *c_value_t
ctypedef object p_value_t

ctypedef deque[PyObjectSmartPtr].iterator deque_it
ctypedef deque[PyObjectSmartPtr].reverse_iterator deque_rit
ctypedef forward_list[PyObjectSmartPtr].iterator forward_list_it
ctypedef list[PyObjectSmartPtr].iterator list_it
ctypedef list[PyObjectSmartPtr].reverse_iterator list_rit
ctypedef map[PyObjectSmartPtr, PyObjectSmartPtr].iterator map_it
ctypedef map[PyObjectSmartPtr, PyObjectSmartPtr].reverse_iterator map_rit
ctypedef multimap[PyObjectSmartPtr, PyObjectSmartPtr].iterator multimap_it
ctypedef multimap[PyObjectSmartPtr, PyObjectSmartPtr].reverse_iterator multimap_rit
ctypedef set[PyObjectSmartPtr].iterator set_it
ctypedef set[PyObjectSmartPtr].reverse_iterator set_rit
ctypedef multiset[PyObjectSmartPtr].iterator multiset_it
ctypedef multiset[PyObjectSmartPtr].reverse_iterator multiset_rit
ctypedef unordered_map[PyObjectSmartPtr, PyObjectSmartPtr].iterator unordered_map_it
ctypedef unordered_multimap[PyObjectSmartPtr, PyObjectSmartPtr].iterator unordered_multimap_it
ctypedef unordered_set[PyObjectSmartPtr].iterator unordered_set_it
ctypedef unordered_multiset[PyObjectSmartPtr].iterator unordered_multiset_it
ctypedef vector[PyObjectSmartPtr].iterator vector_it
ctypedef vector[PyObjectSmartPtr].reverse_iterator vector_rit

cdef class DequeIterator:

	cdef deque_it it

	@staticmethod
	cdef create(deque_it it):
		cdef DequeIterator iter = DequeIterator()
		iter.it = it
		return iter

	cpdef void next(self):
		inc(self.it)

	cpdef void dec(self):
		dec(self.it)

	cpdef object deref(self):
		return <p_value_t>deref(self.it).get()

	def __eq__(self, DequeIterator other):
		return self.it == other.it

	def __neq__(self, DequeIterator other):
		return self.it != other.it


cdef class DequeReverseIterator:

	cdef deque_rit it

	@staticmethod
	cdef create(deque_rit it):
		cdef DequeReverseIterator iter = DequeReverseIterator()
		iter.it = it
		return iter

	cpdef void next(self):
		inc(self.it)

	cpdef void dec(self):
		dec(self.it)

	cpdef object deref(self):
		return <p_value_t>deref(self.it).get()

	def __eq__(self, DequeReverseIterator other):
		return self.it == other.it

	def __neq__(self, DequeReverseIterator other):
		return self.it != other.it

cdef class ForwardListIterator:

	cdef forward_list_it it

	@staticmethod
	cdef create(forward_list_it it):
		cdef ForwardListIterator iter = ForwardListIterator()
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
		cdef ListIterator iter = ListIterator()
		iter.it = it
		return iter

	cpdef void next(self):
		inc(self.it)

	cpdef void dec(self):
		dec(self.it)

	cpdef object deref(self):
		return <p_value_t>deref(self.it).get()

	def __eq__(self, ListIterator other):
		return self.it == other.it


cdef class ListReverseIterator:

	cdef list_rit it

	@staticmethod
	cdef create(list_rit it):
		cdef ListReverseIterator iter = ListReverseIterator()
		iter.it = it
		return iter

	cpdef void next(self):
		inc(self.it)

	cpdef void dec(self):
		dec(self.it)

	cpdef object deref(self):
		return <p_value_t>deref(self.it).get()

	def __eq__(self, ListReverseIterator other):
		return self.it == other.it


cdef class MapIterator:

	cdef map_it it

	@staticmethod
	cdef create(map_it it):
		cdef MapIterator iter = MapIterator()
		iter.it = it
		return iter

	cpdef void next(self):
		inc(self.it)

	cpdef void dec(self):
		dec(self.it)

	cpdef object deref(self):
		cdef pair[PyObjectSmartPtr, PyObjectSmartPtr] result = deref(self.it)
		return (<p_value_t>result.first.get(), <p_value_t>result.second.get())

	def __eq__(self, MapIterator other):
		return self.it == other.it


cdef class MapReverseIterator:

	cdef map_rit it

	@staticmethod
	cdef create(map_rit it):
		cdef MapReverseIterator iter = MapReverseIterator()
		iter.it = it
		return iter

	cpdef void next(self):
		inc(self.it)

	cpdef void dec(self):
		dec(self.it)

	cpdef object deref(self):
		cdef pair[PyObjectSmartPtr, PyObjectSmartPtr] result = deref(self.it)
		return (<p_value_t>result.first.get(), <p_value_t>result.second.get())

	def __eq__(self, MapReverseIterator other):
		return self.it == other.it


cdef class MultiMapIterator:

	cdef multimap_it it

	@staticmethod
	cdef create(multimap_it it):
		cdef MultiMapIterator iter = MultiMapIterator()
		iter.it = it
		return iter

	cpdef void next(self):
		inc(self.it)

	cpdef void dec(self):
		dec(self.it)

	cpdef object deref(self):
		cdef pair[PyObjectSmartPtr, PyObjectSmartPtr] result = deref(self.it)
		return (<p_value_t>result.first.get(), <p_value_t>result.second.get())

	def __eq__(self, MultiMapIterator other):
		return self.it == other.it

cdef class MultiMapReverseIterator:

	cdef multimap_rit it

	@staticmethod
	cdef create(multimap_rit it):
		cdef MultiMapReverseIterator iter = MultiMapReverseIterator()
		iter.it = it
		return iter

	cpdef void next(self):
		inc(self.it)

	cpdef void dec(self):
		dec(self.it)

	cpdef object deref(self):
		cdef pair[PyObjectSmartPtr, PyObjectSmartPtr] result = deref(self.it)
		return (<p_value_t>result.first.get(), <p_value_t>result.second.get())

	def __eq__(self, MultiMapReverseIterator other):
		return self.it == other.it


cdef class SetIterator:

	cdef set_it it

	@staticmethod
	cdef create(set_it it):
		cdef SetIterator iter = SetIterator()
		iter.it = it
		return iter

	cpdef void next(self):
		inc(self.it)

	cpdef void dec(self):
		dec(self.it)

	cpdef object deref(self):
		return <p_value_t>deref(self.it).get()

	def __eq__(self, SetIterator other):
		return self.it == other.it


cdef class SetReverseIterator:

	cdef set_rit it

	@staticmethod
	cdef create(set_rit it):
		cdef SetReverseIterator iter = SetReverseIterator()
		iter.it = it
		return iter

	cpdef void next(self):
		inc(self.it)

	cpdef void dec(self):
		dec(self.it)

	cpdef object deref(self):
		return <p_value_t>deref(self.it).get()

	def __eq__(self, SetReverseIterator other):
		return self.it == other.it


cdef class MultiSetIterator:

	cdef multiset_it it

	@staticmethod
	cdef create(multiset_it it):
		cdef MultiSetIterator iter = MultiSetIterator()
		iter.it = it
		return iter

	cpdef void next(self):
		inc(self.it)

	cpdef void dec(self):
		dec(self.it)

	cpdef object deref(self):
		return <p_value_t>deref(self.it).get()

	def __eq__(self, MultiSetIterator other):
		return self.it == other.it


cdef class MultiSetReverseIterator:

	cdef multiset_rit it

	@staticmethod
	cdef create(multiset_rit it):
		cdef MultiSetReverseIterator iter = MultiSetReverseIterator()
		iter.it = it
		return iter

	cpdef void next(self):
		inc(self.it)

	cpdef void dec(self):
		dec(self.it)

	cpdef object deref(self):
		return <p_value_t>deref(self.it).get()

	def __eq__(self, MultiSetReverseIterator other):
		return self.it == other.it


cdef class UnorderedMapIterator:

	cdef unordered_map_it it

	@staticmethod
	cdef create(unordered_map_it it):
		cdef UnorderedMapIterator iter = UnorderedMapIterator()
		iter.it = it
		return iter

	cpdef void next(self):
		inc(self.it)

	cpdef object deref(self):
		cdef pair[PyObjectSmartPtr, PyObjectSmartPtr] result = deref(self.it)
		return (<p_value_t>result.first.get(), <p_value_t>result.second.get())

	def __eq__(self, UnorderedMapIterator other):
		return self.it == other.it


cdef class UnorderedMultiMapIterator:

	cdef unordered_multimap_it it

	@staticmethod
	cdef create(unordered_multimap_it it):
		cdef UnorderedMultiMapIterator iter = UnorderedMultiMapIterator()
		iter.it = it
		return iter

	cpdef void next(self):
		inc(self.it)

	cpdef object deref(self):
		cdef pair[PyObjectSmartPtr, PyObjectSmartPtr] result = deref(self.it)
		return (<p_value_t>result.first.get(), <p_value_t>result.second.get())

	def __eq__(self, UnorderedMultiMapIterator other):
		return self.it == other.it


cdef class UnorderedSetIterator:

	cdef unordered_set_it it

	@staticmethod
	cdef create(unordered_set_it it):
		cdef UnorderedSetIterator iter = UnorderedSetIterator()
		iter.it = it
		return iter

	cpdef void next(self):
		inc(self.it)

	cpdef object deref(self):
		return <p_value_t>deref(self.it).get()

	def __eq__(self, UnorderedSetIterator other):
		return self.it == other.it


cdef class UnorderedMultiSetIterator:

	cdef unordered_multiset_it it

	@staticmethod
	cdef create(unordered_multiset_it it):
		cdef UnorderedMultiSetIterator iter = UnorderedMultiSetIterator()
		iter.it = it
		return iter

	cpdef void next(self):
		inc(self.it)

	cpdef object deref(self):
		return <p_value_t>deref(self.it).get()

	def __eq__(self, UnorderedMultiSetIterator other):
		return self.it == other.it


cdef class VectorIterator:

	cdef vector_it it

	@staticmethod
	cdef create(vector_it it):
		cdef VectorIterator iter = VectorIterator()
		iter.it = it
		return iter

	cpdef void next(self):
		inc(self.it)

	cpdef void dec(self):
		dec(self.it)

	cpdef object deref(self):
		return <p_value_t>deref(self.it).get()

	def __eq__(self, VectorIterator other):
		return self.it == other.it


cdef class VectorReverseIterator:

	cdef vector_rit it

	@staticmethod
	cdef create(vector_rit it):
		cdef VectorReverseIterator iter = VectorReverseIterator()
		iter.it = it
		return iter

	cpdef void next(self):
		inc(self.it)

	cpdef void dec(self):
		dec(self.it)

	cpdef object deref(self):
		return <p_value_t>deref(self.it).get()

	def __eq__(self, VectorReverseIterator other):
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
		cdef deque_it it = self.deque.begin()
		while it != self.deque.end():
			yield <p_value_t>deref(it).get()
			inc(it)

	# Capacity

	cpdef bint empty(self):
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

	cpdef DequeIterator erase(self, DequeIterator pos):
		return DequeIterator.create(self.deque.erase(pos.it))

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
		cdef forward_list_it it = self.list.begin()
		while it != self.list.end():
			yield <p_value_t>deref(it).get()
			inc(it)

	# Capacity

	cpdef bint empty(self):
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
		cdef list_it it = self.list.begin()
		while it != self.list.end():
			yield <p_value_t>deref(it).get()
			inc(it)

	# Capacity

	cpdef bint empty(self):
		return self.list.empty()

	cpdef size_t size(self):
		return self.list.size()

	cpdef size_t max_size(self):
		return self.list.max_size()

	# Modifiers

	cpdef void clear(self):
		self.list.clear()

	cpdef ListIterator erase(self, ListIterator pos):
		return ListIterator.create(self.list.erase(pos.it))

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
		cdef map_it it = self.map.begin()
		cdef pair[PyObjectSmartPtr, PyObjectSmartPtr] result
		while it != self.map.end():
			result = deref(it)
			yield <p_value_t>result.first.get()
			inc(it)

	def values(self):
		cdef map_it it = self.map.begin()
		cdef pair[PyObjectSmartPtr, PyObjectSmartPtr] result
		while it != self.map.end():
			result = deref(it)
			yield <p_value_t>result.second.get()
			inc(it)

	def items(self):
		cdef map_it it = self.map.begin()
		cdef pair[PyObjectSmartPtr, PyObjectSmartPtr] result
		while it != self.map.end():
			result = deref(it)
			yield (<p_value_t>result.first.get(), <p_value_t>result.second.get())
			inc(it)

	def __iter__(self):
		return self.keys()

	# Capacity

	cpdef bint empty(self):
		return self.map.empty()

	cpdef size_t size(self):
		return self.map.size()

	cpdef size_t max_size(self):
		return self.map.max_size()

	# Modifiers

	cpdef void clear(self):
		self.map.clear()

	cpdef bint insert(self, object key, object value):

		cdef pair[PyObjectSmartPtr, PyObjectSmartPtr] item = pair[PyObjectSmartPtr, PyObjectSmartPtr](PyObjectSmartPtr(<c_value_t>key), PyObjectSmartPtr(<c_value_t>value))
		cdef pair[map_it, bint] result = self.map.insert(item)
		return result.second

	cpdef MapIterator erase(self, MapIterator pos):
		return MapIterator.create(self.map.erase(pos.it))

	# Lookup

	cpdef size_t count(self, object key):
		cdef size_t result = self.map.count(PyObjectSmartPtr(<c_value_t>key))

		return result

	cpdef object find(self, object key):
		cdef map_it it = self.map.find(PyObjectSmartPtr(<c_value_t>key))

		if it != self.map.end():
			return <p_value_t>deref(it).second.get()
		else:
			raise KeyError(key)

	""" C++ 20
	cpdef bint contains(self, object key):
		return self.map.contains(PyObjectSmartPtr(<c_value_t>key))
	"""

	# Non-member functions

	def __eq__(self, Map other) -> bool:
		return self.map == other.map

	# Convenience

	def update(self, it: Iterable[Tuple[Any, Any]]) -> None:
		for k, v in it:
			self.map[PyObjectSmartPtr(<c_value_t>k)] = PyObjectSmartPtr(<c_value_t>v)

cdef class MultiMap:

	cdef multimap[PyObjectSmartPtr, PyObjectSmartPtr] multimap

	def __init__(self):
		pass

	# Iterators

	cpdef MultiMapIterator begin(self):
		return MultiMapIterator.create(self.multimap.begin())

	cpdef MultiMapIterator end(self):
		return MultiMapIterator.create(self.multimap.end())

	def keys(self):
		cdef multimap_it it = self.multimap.begin()
		cdef pair[PyObjectSmartPtr, PyObjectSmartPtr] result
		while it != self.multimap.end():
			result = deref(it)
			yield <p_value_t>result.first.get()
			inc(it)

	def values(self):
		cdef multimap_it it = self.multimap.begin()
		cdef pair[PyObjectSmartPtr, PyObjectSmartPtr] result
		while it != self.multimap.end():
			result = deref(it)
			yield <p_value_t>result.second.get()
			inc(it)

	def items(self):
		cdef multimap_it it = self.multimap.begin()
		cdef pair[PyObjectSmartPtr, PyObjectSmartPtr] result
		while it != self.multimap.end():
			result = deref(it)
			yield (<p_value_t>result.first.get(), <p_value_t>result.second.get())
			inc(it)

	def __iter__(self):
		return self.keys()

	# Capacity

	cpdef bint empty(self):
		return self.multimap.empty()

	cpdef size_t size(self):
		return self.multimap.size()

	cpdef size_t max_size(self):
		return self.multimap.max_size()

	# Modifiers

	cpdef void clear(self):
		self.multimap.clear()

	cpdef MultiMapIterator insert(self, object key, object value):

		cdef pair[PyObjectSmartPtr, PyObjectSmartPtr] item = pair[PyObjectSmartPtr, PyObjectSmartPtr](PyObjectSmartPtr(<c_value_t>key), PyObjectSmartPtr(<c_value_t>value))
		cdef multimap_it it = self.multimap.insert(item)
		return MultiMapIterator.create(it)

	cpdef MultiMapIterator erase(self, MultiMapIterator pos):
		return MultiMapIterator.create(self.multimap.erase(pos.it))

	# Lookup

	cpdef size_t count(self, object key):
		cdef size_t result = self.multimap.count(PyObjectSmartPtr(<c_value_t>key))

		return result

	cpdef object find(self, object key):
		cdef multimap_it it = self.multimap.find(PyObjectSmartPtr(<c_value_t>key))

		if it != self.multimap.end():
			return <p_value_t>deref(it).second.get()
		else:
			raise KeyError(key)

	cpdef equal_range(self, object key):
		cdef pair[multimap_it, multimap_it] result = self.multimap.equal_range(PyObjectSmartPtr(<c_value_t>key))
		return MultiMapIterator.create(result.first), MultiMapIterator.create(result.second)

	""" C++ 20
	cpdef bint contains(self, object key):
		return self.multimap.contains(PyObjectSmartPtr(<c_value_t>key))
	"""

	# Non-member functions

	def __eq__(self, MultiMap other) -> bool:
		return self.multimap == other.multimap

	# Convenience

	def update(self, it: Iterable[Tuple[Any, Any]]) -> None:
		cdef pair[PyObjectSmartPtr, PyObjectSmartPtr] item
		for key, value in it:
			item = pair[PyObjectSmartPtr, PyObjectSmartPtr](PyObjectSmartPtr(<c_value_t>key), PyObjectSmartPtr(<c_value_t>value))
			self.multimap.insert(item)


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
		cdef set_it it = self.set.begin()
		while it != self.set.end():
			yield <p_value_t>deref(it).get()
			inc(it)

	# Capacity

	cpdef bint empty(self):
		return self.set.empty()

	cpdef size_t size(self):
		return self.set.size()

	cpdef size_t max_size(self):
		return self.set.max_size()

	# Modifiers

	cpdef void clear(self):
		self.set.clear()

	cpdef bint insert(self, object value):
		cdef pair[set_it, bint] result = self.set.insert(PyObjectSmartPtr(<c_value_t>value))

		return result.second

	cpdef SetIterator erase(self, SetIterator pos):
		return SetIterator.create(self.set.erase(pos.it))

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
		cdef set_it it = self.set.find(PyObjectSmartPtr(<c_value_t>value))

		if it != self.set.end():
			return <p_value_t>deref(it).get()
		else:
			raise KeyError(value)

	cpdef equal_range(self, object key):
		cdef pair[set_it, set_it] result = self.set.equal_range(PyObjectSmartPtr(<c_value_t>key))

		return SetIterator.create(result.first), SetIterator.create(result.second)

	# Non-member functions

	def __eq__(self, Set other) -> bool:
		return self.set == other.set

	# Convenience

	def update(self, it: Iterable[Any]) -> None:
		for value in it:
			self.set.insert(PyObjectSmartPtr(<c_value_t>value))

cdef class MultiSet:

	cdef multiset[PyObjectSmartPtr] multiset

	def __init__(self):
		pass

	# Iterators

	cpdef MultiSetIterator begin(self):
		return MultiSetIterator.create(self.multiset.begin())

	cpdef MultiSetIterator end(self):
		return MultiSetIterator.create(self.multiset.end())

	def __iter__(self):
		cdef multiset_it it = self.multiset.begin()
		while it != self.multiset.end():
			yield <p_value_t>deref(it).get()
			inc(it)

	# Capacity

	cpdef bint empty(self):
		return self.multiset.empty()

	cpdef size_t size(self):
		return self.multiset.size()

	cpdef size_t max_size(self):
		return self.multiset.max_size()

	# Modifiers

	cpdef void clear(self):
		self.multiset.clear()

	cpdef MultiSetIterator insert(self, object value):
		cdef multiset_it it = self.multiset.insert(PyObjectSmartPtr(<c_value_t>value))

		return MultiSetIterator.create(it)

	cpdef MultiSetIterator erase(self, MultiSetIterator pos):
		return MultiSetIterator.create(self.multiset.erase(pos.it))

	cpdef void swap(self, MultiSet other):
		self.multiset.swap(other.multiset)

	""" C++ 17
	cpdef void merge(self, MultiSet source):
		self.multiset.merge(source.multiset)
	"""

	# Lookup

	cpdef size_t count(self, object key):
		cdef size_t result = self.multiset.count(PyObjectSmartPtr(<c_value_t>key))

		return result

	cpdef object find(self, object key):
		cdef multiset_it it = self.multiset.find(PyObjectSmartPtr(<c_value_t>key))

		if it != self.multiset.end():
			return <p_value_t>deref(it).get()
		else:
			raise KeyError(key)

	cpdef equal_range(self, object key):
		cdef pair[multiset_it, multiset_it] result = self.multiset.equal_range(PyObjectSmartPtr(<c_value_t>key))

		return MultiSetIterator.create(result.first), MultiSetIterator.create(result.second)

	# Non-member functions

	def __eq__(self, MultiSet other) -> bool:
		return self.multiset == other.multiset

	# Convenience

	def update(self, it: Iterable[Any]) -> None:
		for value in it:
			self.multiset.insert(PyObjectSmartPtr(<c_value_t>value))

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
		cdef unordered_map_it it = self.map.begin()
		cdef pair[PyObjectSmartPtr, PyObjectSmartPtr] result
		while it != self.map.end():
			result = deref(it)
			yield <p_value_t>result.first.get()
			inc(it)

	def values(self):
		cdef unordered_map_it it = self.map.begin()
		cdef pair[PyObjectSmartPtr, PyObjectSmartPtr] result
		while it != self.map.end():
			result = deref(it)
			yield <p_value_t>result.second.get()
			inc(it)

	def items(self):
		cdef unordered_map_it it = self.map.begin()
		cdef pair[PyObjectSmartPtr, PyObjectSmartPtr] result
		while it != self.map.end():
			result = deref(it)
			yield (<p_value_t>result.first.get(), <p_value_t>result.second.get())
			inc(it)

	def __iter__(self):
		return self.keys()

	# Capacity

	cpdef bint empty(self):
		return self.map.empty()

	cpdef size_t size(self):
		return self.map.size()

	cpdef size_t max_size(self):
		return self.map.max_size()

	# Modifiers

	cpdef void clear(self):
		self.map.clear()

	cpdef bint insert(self, object key, object value):

		cdef pair[PyObjectSmartPtr, PyObjectSmartPtr] item = pair[PyObjectSmartPtr, PyObjectSmartPtr](PyObjectSmartPtr(<c_value_t>key), PyObjectSmartPtr(<c_value_t>value))
		cdef pair[unordered_map_it, bint] result = self.map.insert(item)
		return result.second

	cpdef UnorderedMapIterator erase(self, UnorderedMapIterator pos):
		return UnorderedMapIterator.create(self.map.erase(pos.it))

	# Lookup

	cpdef size_t count(self, object key):
		cdef size_t result = self.map.count(PyObjectSmartPtr(<c_value_t>key))

		return result

	cpdef object find(self, object key):
		cdef unordered_map_it it = self.map.find(PyObjectSmartPtr(<c_value_t>key))

		if it != self.map.end():
			return <p_value_t>deref(it).second.get()
		else:
			raise KeyError(key)

	""" C++ 20
	cpdef bint contains(self, object key):
		return self.map.contains(PyObjectSmartPtr(<c_value_t>key))
	"""

	# Convenience

	def update(self, it: Iterable[Tuple[Any, Any]]) -> None:
		for k, v in it:
			self.map[PyObjectSmartPtr(<c_value_t>k)] = PyObjectSmartPtr(<c_value_t>v)

cdef class UnorderedMultiMap:

	cdef unordered_multimap[PyObjectSmartPtr, PyObjectSmartPtr] multimap

	def __init__(self):
		pass

	# Iterators

	cpdef UnorderedMultiMapIterator begin(self):
		return UnorderedMultiMapIterator.create(self.multimap.begin())

	cpdef UnorderedMultiMapIterator end(self):
		return UnorderedMultiMapIterator.create(self.multimap.end())

	def keys(self):
		cdef unordered_multimap_it it = self.multimap.begin()
		cdef pair[PyObjectSmartPtr, PyObjectSmartPtr] result
		while it != self.multimap.end():
			result = deref(it)
			yield <p_value_t>result.first.get()
			inc(it)

	def values(self):
		cdef unordered_multimap_it it = self.multimap.begin()
		cdef pair[PyObjectSmartPtr, PyObjectSmartPtr] result
		while it != self.multimap.end():
			result = deref(it)
			yield <p_value_t>result.second.get()
			inc(it)

	def items(self):
		cdef unordered_multimap_it it = self.multimap.begin()
		cdef pair[PyObjectSmartPtr, PyObjectSmartPtr] result
		while it != self.multimap.end():
			result = deref(it)
			yield (<p_value_t>result.first.get(), <p_value_t>result.second.get())
			inc(it)

	def __iter__(self):
		return self.keys()

	# Capacity

	cpdef bint empty(self):
		return self.multimap.empty()

	cpdef size_t size(self):
		return self.multimap.size()

	cpdef size_t max_size(self):
		return self.multimap.max_size()

	# Modifiers

	cpdef void clear(self):
		self.multimap.clear()

	cpdef UnorderedMultiMapIterator insert(self, object key, object value):

		cdef pair[PyObjectSmartPtr, PyObjectSmartPtr] item = pair[PyObjectSmartPtr, PyObjectSmartPtr](PyObjectSmartPtr(<c_value_t>key), PyObjectSmartPtr(<c_value_t>value))
		cdef unordered_multimap_it it = self.multimap.insert(item)
		return UnorderedMultiMapIterator.create(it)

	cpdef UnorderedMultiMapIterator erase(self, UnorderedMultiMapIterator pos):
		return UnorderedMultiMapIterator.create(self.multimap.erase(pos.it))

	cpdef void swap(self, UnorderedMultiMap other):
		self.multimap.swap(other.multimap)

	""" C++ 17
	cpdef void merge_umap(self, UnorderedMap source):
		self.multimap.merge(source.map)

	cpdef void merge(self, UnorderedMultiMap source):
		self.multimap.merge(source.multimap)
	"""

	# Lookup

	cpdef size_t count(self, object key):
		cdef size_t result = self.multimap.count(PyObjectSmartPtr(<c_value_t>key))

		return result

	cpdef object find(self, object key):
		cdef unordered_multimap_it it = self.multimap.find(PyObjectSmartPtr(<c_value_t>key))

		if it != self.multimap.end():
			return <p_value_t>deref(it).second.get()
		else:
			raise KeyError(key)

	cpdef equal_range(self, object key):
		cdef pair[unordered_multimap_it, unordered_multimap_it] result = self.multimap.equal_range(PyObjectSmartPtr(<c_value_t>key))
		return UnorderedMultiMapIterator.create(result.first), UnorderedMultiMapIterator.create(result.second)

	""" C++ 20
	cpdef bint contains(self, object key):
		return self.multimap.contains(PyObjectSmartPtr(<c_value_t>key))
	"""

	# Hash policy

	""" missing in `Cython==3.0.0a11`
	cpdef float load_factor(self):
		return self.multimap.load_factor()
	"""

	cpdef float max_load_factor(self):
		return self.multimap.max_load_factor()

	# Non-member functions

	def __eq__(self, UnorderedMultiMap other) -> bool:
		return self.multimap == other.multimap

	# Convenience

	def update(self, it: Iterable[Tuple[Any, Any]]) -> None:
		cdef pair[PyObjectSmartPtr, PyObjectSmartPtr] item
		for key, value in it:
			item = pair[PyObjectSmartPtr, PyObjectSmartPtr](PyObjectSmartPtr(<c_value_t>key), PyObjectSmartPtr(<c_value_t>value))
			self.multimap.insert(item)

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

	cpdef bint empty(self):
		return self.set.empty()

	cpdef size_t size(self):
		return self.set.size()

	cpdef size_t max_size(self):
		return self.set.max_size()

	# Modifiers

	cpdef void clear(self):
		self.set.clear()

	cpdef bint insert(self, object value):
		cdef pair[unordered_set_it, bint] result = self.set.insert(PyObjectSmartPtr(<c_value_t>value))

		return result.second

	cpdef UnorderedSetIterator erase(self, UnorderedSetIterator pos):
		return UnorderedSetIterator.create(self.set.erase(pos.it))

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

	# Hash policy

	cpdef float load_factor(self):
		return self.set.load_factor()

	cpdef float max_load_factor(self):
		return self.set.max_load_factor()

	# Non-member functions

	def __eq__(self, UnorderedSet other) -> bool:
		return self.set == other.set

	# Convenience

	def update(self, it: Iterable[Any]) -> None:
		for value in it:
			self.set.insert(PyObjectSmartPtr(<c_value_t>value))

cdef class UnorderedMultiSet:

	cdef unordered_multiset[PyObjectSmartPtr] multiset

	def __init__(self):
		pass

	# Iterators

	cpdef UnorderedMultiSetIterator begin(self):
		return UnorderedMultiSetIterator.create(self.multiset.begin())

	cpdef UnorderedMultiSetIterator end(self):
		return UnorderedMultiSetIterator.create(self.multiset.end())

	def __iter__(self):
		cdef unordered_multiset_it it = self.multiset.begin()
		while it != self.multiset.end():
			yield <p_value_t>deref(it).get()
			inc(it)

	# Capacity

	cpdef bint empty(self):
		return self.multiset.empty()

	cpdef size_t size(self):
		return self.multiset.size()

	cpdef size_t max_size(self):
		return self.multiset.max_size()

	# Modifiers

	cpdef void clear(self):
		self.multiset.clear()

	cpdef UnorderedMultiSetIterator insert(self, object value):
		cdef unordered_multiset_it it = self.multiset.insert(PyObjectSmartPtr(<c_value_t>value))

		return UnorderedMultiSetIterator.create(it)

	cpdef UnorderedMultiSetIterator erase(self, UnorderedMultiSetIterator pos):
		return UnorderedMultiSetIterator.create(self.multiset.erase(pos.it))

	cpdef void swap(self, UnorderedMultiSet other):
		self.multiset.swap(other.multiset)

	# extract()

	""" C++ 17
	cpdef void merge(self, UnorderedMultiSet source):
		self.multiset.merge(source.multiset)
	"""

	# Lookup

	cpdef size_t count(self, object key):
		cdef size_t result = self.multiset.count(PyObjectSmartPtr(<c_value_t>key))

		return result

	cpdef object find(self, object key):
		cdef unordered_multiset_it it = self.multiset.find(PyObjectSmartPtr(<c_value_t>key))

		if it != self.multiset.end():
			return <p_value_t>deref(it).get()
		else:
			raise KeyError(key)

	cpdef equal_range(self, object key):
		cdef pair[unordered_multiset_it, unordered_multiset_it] result = self.multiset.equal_range(PyObjectSmartPtr(<c_value_t>key))

		return (UnorderedSetIterator.create(result.first), UnorderedSetIterator.create(result.second))

	# Hash policy

	cpdef float load_factor(self):
		return self.multiset.load_factor()

	cpdef float max_load_factor(self):
		return self.multiset.max_load_factor()

	# Non-member functions

	def __eq__(self, UnorderedMultiSet other) -> bool:
		return self.multiset == other.multiset

	# Convenience

	def update(self, it: Iterable[Any]) -> None:
		for value in it:
			self.multiset.insert(PyObjectSmartPtr(<c_value_t>value))

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

	cpdef VectorReverseIterator rbegin(self):
		return VectorReverseIterator.create(self.vector.rbegin())

	cpdef VectorReverseIterator rend(self):
		return VectorReverseIterator.create(self.vector.rend())

	def __iter__(self):
		cdef vector_it it = self.vector.begin()
		while it != self.vector.end():
			yield <p_value_t>deref(it).get()
			inc(it)

	def __reversed__(self):
		cdef vector_rit it = self.vector.rbegin()
		while it != self.vector.rend():
			yield <p_value_t>deref(it).get()
			inc(it)

	# Capacity

	cpdef bint empty(self):
		return self.vector.empty()

	cpdef size_t size(self):
		return self.vector.size()

	def __len__(self):
		return self.size()

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

	cpdef VectorIterator insert(self, VectorIterator pos, object value):
		return VectorIterator.create(self.vector.insert(pos.it, PyObjectSmartPtr(<c_value_t>value)))

	# cpdef emplace()

	cpdef VectorIterator erase(self, VectorIterator pos):
		return VectorIterator.create(self.vector.erase(pos.it))

	cpdef void push_back(self, object value):
		self.vector.push_back(PyObjectSmartPtr(<c_value_t>value))

	# cpdef emplace_back()

	cpdef void pop_back(self):
		self.vector.pop_back()

	cpdef void resize(self, size_t count):
		self.vector.resize(count)

	cpdef void swap(self, Vector other):
		self.vector.swap(other.vector)

	# Non-member functions

	def __eq__(self, Vector other) -> bool:
		return self.vector == other.vector

	# Convenience

	def update(self, it: Iterable[Any]) -> None:
		for value in it:
			self.vector.push_back(PyObjectSmartPtr(<c_value_t>value))
