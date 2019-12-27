# Why

Many permutation algorithms generate permutations based on the permutation that came before. For example, [Heap's Algorithm](https://en.wikipedia.org/wiki/Heap's_algorithm) uses a swapping method that swaps two elements every time to create the next permutation.

```
A B C D <-- swap A & B to get
B A C D <-- swap B & C to get
C A B D <-- swap A & C to get
A C B D ... etc
```

Because this requires previous permutations, it's inefficient to get a permutation far down the list. For example if you have a 10 item set, that's 3,628,800 unique permutations. If you want permutation 3,000,000 you have to generate the 2,999,999 before that.

This algorithm aims to generate permutations based only on the original set of items, and the offset (e.g. 3,000,000) without any knowledge of previous permutations.

# How it works

This works by taking advantage of the fact that one valid way to generate permutations keeps consecutive runs of each item in the first slot of the permutation. Also, the remaining items mirror what the next-smallest permutation does, including the rotating item in the first slot.

For example, a 4-item permutation:

```
A B C D
A B D C
A C B D
A C D B
A D B C
A D C B
B A C D
B A D C
B C A D
B C D A
B D A C
B D C A
C A B D
C A D B
C B A D
C B D A
C D A B
C D B A
D A B C
D A C B
D B A C
D B C A
D C A B
D C B A
```

There are 24 permutations total, which is 4 [factorial](https://en.wikipedia.org/wiki/Factorial). That ends up having 4 sections, and each section features one of each item as the first item in the permutation. First A, then B, etc.

You can see that `A` is in the first slot and the rest mirror the pattern from the 3-item permutation. Each section lasts for the total number of permutations divided by the number of items in the set. 4-item set, 24 permutations total, 24/4 = 6 permutations per section.

If you can figure out which section you're in based on the offset, it will be the index of the item in the set that goes in the first slot of the first permutation. Note that index, reduce the number of items in the permutation and run it through again and find the new index. Do this until there are only 2 items left. No need to do it for a one-item permutation beacuse there's only one option.

Loop through the indexes and extract the item at that index into a new array and move to the next. Removing all the items will leave you with one item left which will be the last item in the permutation.

## Visualization

We'll grab the 9th permutation (a.k.a. offset 8) from a 4-item set.

```ruby
set = A B C D
offset = 8
length = 4
section_length = factorial(length) / length # 6
current_section = offset / section_length # 1, integer division

list_of_indexes = [1]
length = length - 1

offset = 8
length = 3
section_length = factorial(length) / length # 2
# wrap the offset around the total number of permutations
wrapped_offset = offset % factorial(length) # 2
current_section = wrapped_offset / section_length # 1

list_of_indexes = [1, 1]
length = length - 1

offset = 8
length = 2
section_length = factorial(length) / length # 1
wrapped_offset = offset % factorial(length) # 0
current_section = wrapped_offset / section_length # 0

list_of_indexes = [1, 1, 0]
```

Then take the list of indexes and grab those items one-by-one from the oritinal set:

```
list_of_indexes = [1, 1, 0]
set = A B C D
permutation = empty

list_of_indexes = [_, 1, 0]
set = A C D
permutation = B

list_of_indexes = [_, _, 0]
set = A D
permutation = B C

list_of_indexes = [_, _, _]
set = D
permutation = B C A
```

Then add the final leftover item to the end of the permutation

```
set = empty
permutation = B C A D
```
