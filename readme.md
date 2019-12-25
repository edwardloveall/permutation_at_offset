`section size`: number of permutations divided by the number of items in the set

```ruby
set = %w(a, b, c) # length 3
permutation_length = Math.gamma(set.count + 1).to_i # 6
section_length = permutation_length / set.count # 2
```

`current section`: when iterating through all the permutations, each `section size` segment is one section. the `current section` is the one the iterator is inside of.

```
section size = 2
section count = 3

section | index
0       | 0
0       | 1
1       | 2
1       | 3 <-- current section: 1, index: 3
2       | 4
2       | 5
```

`focus item`: the item from index in the set that matches the `curent section`

```
set = %w(a, b, c)
current_section: 1
focus_item: `b`
```

---

# algorithm instructions

## Goal

To retrive a permutation by index without calculating all permutations previous.

Example:

```ruby
set = %w(a, b, c)
offset = 2
# offset is zero-indexed
permutation_at_offset(set, offset) # ["b", "a", "c"]
```

## Process

Arguments are the `set` of items and the `offset` desired. Figure out:

* The number of sections
* `section size`
* `current section`
* `focus item`

Put the focus item at the first index. Take the remaining items and repeat the steps again with the smaller array. If the set length is 2, either keep the items in place if the index is even, or flip them if it's odd.
