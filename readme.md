# Why

Many permutation algorithms generate permutations based on the permutation that came before. For example, [Heap's Algorithm](https://en.wikipedia.org/wiki/Heap's_algorithm) uses a swapping method that swaps two elements every time to create the next permutation.

```
A B C D <-- swap A & B to get
B A C D <-- swap B & C to get
C A B D <-- swap A & C to get
A C B D
etc.
```

Because this requires previous permutations, it's inefficient to get a permutation far down the list. For example if you have a 10 item set, that's 3,628,800 unique permutations. If you want permutation 3,000,000 you have to generate the 2,999,999 before that.

This algorithm aims to generate permutations based only on the number or offset (e.g. 3,000,000) without any knowledge of previous permutations.

# How it works

This works by taking advantage of the fact that one valid way to generate permutations keeps one items in the first slot of the permutation. The rest of the numbers also mirrors what the next-smallest permutation does, including the item in the first slot.

For example, with a 3 item permutation:

```
A	B	C
A	C	B
B	A	C
B	C	A
C	A	B
C	B	A
```

There are 6 permutations total, which is 3 [factorial](https://en.wikipedia.org/wiki/Factorial). That means there are 3 sections, and each section features a letter in the first slot. Here's an example of the first six permutations from a 4-item set:

```
A	B	C	D
A	B	D	C
A	C	B	D
A	C	D	B
A	D	B	C
A	D	C	B
```

You can see that `A` is in the first slot and the rest mirror the pattern from the 3-item permutation. Each section lasts for the total number of permutations divided by the number of items in the set. 3-item set, 6 permutations total, 6/3 = 2 permutations per section. 4-item set, 24 permutations, 24/4 = 6.

If you can figure out which section you're in, it will be the index of the item in the set that goes in the first slot of the first permutation. Find the first item, drop that item from the set, and recurse through the algorithm again with the new set. It will find the correct item to put in the "first" slot and keep going through until there is only one item left.

Combine them all together and you have your permutation.

## Definitions

`section size`: number of permutations divided by the number of items in the set

```ruby
set = %w(a, b, c) # length 3
permutation_length = Math.gamma(set.count + 1).to_i # 6
section_length = permutation_length / set.count # 2
```

`current section`: when iterating through all the permutations, each `section size` group of permutations is one section. The `current section` is the one the offset is looking at.

```
section size = 2
section count = 3

section | offset
0       | 0
0       | 1
1       | 2
1       | 3 <-- current section: 1, offset: 3
2       | 4
2       | 5
```

`focus item`: the item from index in the set that matches the `current section`

```
set = %w(a, b, c)
current_section: 1
focus_item: `b`
```

---

# Algorithm Instructions

## Goal

To retrieve a permutation by index without calculating all previous permutations.

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
