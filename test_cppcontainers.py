from cppcontainers import (
    Deque,
    ForwardList,
    List,
    Map,
    MultiSet,
    Set,
    UnorderedMap,
    UnorderedMultiSet,
    UnorderedSet,
    Vector,
)

sequences = [Deque, ForwardList, List, Set, UnorderedSet, Vector, MultiSet, UnorderedMultiSet]
mappings = [Map, UnorderedMap]

values = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
items = [("a", 1), ("b", 2), ("c", 3), ("d", 4), ("e", 5)]


def setup(sequences, mappings):
    for c in sequences:
        obj = c()
        obj.update(values)
        yield obj

    for c in mappings:
        obj = c()
        obj.update(items)
        yield obj


def print_list(objs):
    for obj in objs:
        print(list(obj))


def self_equal(objs):
    for obj in objs:
        assert obj == obj
        assert obj is not None


def its_uneqial(objs):
    for obj in objs:
        assert obj.begin() == obj.begin()
        assert obj.begin() != obj.end()


if __name__ == "__main__":
    objs = list(setup(sequences, mappings))

    print_list(objs)
    self_equal(objs)
    its_uneqial(objs)
