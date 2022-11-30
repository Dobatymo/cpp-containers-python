import unittest

from genutility.test import MyTestCase

from cppcontainers import (
    Deque,
    ForwardList,
    List,
    Map,
    MultiMap,
    MultiSet,
    Set,
    UnorderedMap,
    UnorderedMultiMap,
    UnorderedMultiSet,
    UnorderedSet,
    Vector,
)

values = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
items = [("a", 1), ("b", 2), ("c", 3), ("d", 4), ("e", 5)]


class CppContainersTest(MyTestCase):

    # Sequence

    def test_vector(self):
        obj = Vector()
        obj.update(values)

        assert list(obj) == values
        assert list(reversed(obj)) == list(reversed(values))

        assert obj == obj
        assert obj is not None

        assert obj.begin() == obj.begin()
        assert obj.begin() != obj.end()

        assert not obj.empty()
        assert obj.size() == len(values)

        obj.erase(obj.begin())
        assert list(obj) == values[1:]

    def test_deque(self):
        obj = Deque()
        obj.update(values)

        assert list(obj) == values, list(obj)

        assert obj == obj
        assert obj is not None

        assert obj.begin() == obj.begin()
        assert obj.begin() != obj.end()

        assert not obj.empty()
        assert obj.size() == len(values)

        obj.erase(obj.begin())
        assert list(obj) == values[1:]

    def test_forwardlist(self):
        obj = ForwardList()
        obj.update(values)

        assert list(obj) == list(reversed(values))

        assert obj == obj
        assert obj is not None

        assert not obj.empty()

        assert obj.begin() == obj.begin()
        assert obj.begin() != obj.end()

    def test_list(self):
        obj = List()
        obj.update(values)

        assert list(obj) == values, list(obj)

        assert obj == obj
        assert obj is not None

        assert obj.begin() == obj.begin()
        assert obj.begin() != obj.end()

        assert not obj.empty()
        assert obj.size() == len(values)

        obj.erase(obj.begin())
        assert list(obj) == values[1:]

    # Associative

    def test_set(self):
        obj = Set()
        obj.update(values)

        assert list(obj) == values
        assert obj == obj
        assert obj is not None

        assert obj.begin() == obj.begin()
        assert obj.begin() != obj.end()

        assert not obj.empty()
        assert obj.size() == len(values)

    def test_multiset(self):
        obj = MultiSet()
        obj.update(values)

        assert list(obj) == values
        assert obj == obj
        assert obj is not None

        assert obj.begin() == obj.begin()
        assert obj.begin() != obj.end()

        assert not obj.empty()
        assert obj.size() == len(values)

    def test_map(self):
        obj = Map()
        obj.update(items)

        self.assertUnorderedSeqEqual(list(obj), [k for k, v in items])
        assert obj == obj
        assert obj is not None

        assert obj.begin() == obj.begin()
        assert obj.begin() != obj.end()

        assert not obj.empty()
        assert obj.size() == len(items)

    def test_multimap(self):
        obj = MultiMap()
        obj.update(items)

        self.assertUnorderedSeqEqual(list(obj), [k for k, v in items])
        assert obj == obj
        assert obj is not None

        assert obj.begin() == obj.begin()
        assert obj.begin() != obj.end()

        assert not obj.empty()
        assert obj.size() == len(items)

    # Unordered associative

    def test_unorderedset(self):
        obj = UnorderedSet()
        obj.update(values)

        self.assertUnorderedSeqEqual(list(obj), values)
        assert obj == obj
        assert obj is not None

        assert obj.begin() == obj.begin()
        assert obj.begin() != obj.end()

        assert not obj.empty()
        assert obj.size() == len(values)

    def test_unorderedmultiset(self):
        obj = UnorderedMultiSet()
        obj.update(values)

        self.assertUnorderedSeqEqual(list(obj), values)
        assert obj == obj
        assert obj is not None

        assert obj.begin() == obj.begin()
        assert obj.begin() != obj.end()

        assert not obj.empty()
        assert obj.size() == len(values)

    def test_unorderedmap(self):
        obj = UnorderedMap()
        obj.update(items)

        self.assertUnorderedSeqEqual(list(obj), [k for k, v in items])
        assert obj == obj
        assert obj is not None

        assert obj.begin() == obj.begin()
        assert obj.begin() != obj.end()

        assert not obj.empty()
        assert obj.size() == len(items)

    def test_unorderedmultimap(self):
        obj = UnorderedMultiMap()
        obj.update(items)

        self.assertUnorderedSeqEqual(list(obj), [k for k, v in items])
        assert obj == obj
        assert obj is not None

        assert obj.begin() == obj.begin()
        assert obj.begin() != obj.end()

        assert not obj.empty()
        assert obj.size() == len(items)


if __name__ == "__main__":
    unittest.main()
