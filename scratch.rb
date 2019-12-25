# require "pry"

def two_item_permutation(set, offset)
  if offset.even?
    set
  else
    [set[1], set[0]]
  end
end

def permutation_at_offset(set, offset)
  result = []
  permutation_count = Math.gamma(set.size + 1).to_i
  if set.size == 1
    set
  elsif set.size == 2
    two_item_permutation(set, offset)
  else
    wrapped_offset = offset % permutation_count
    section_size = Math.gamma(set.size).to_i
    current_section = wrapped_offset / section_size
    focus_item = set[current_section]

    result[0] = focus_item
    new_set = set.dup
    new_set.delete_at(current_section)
    result + permutation_at_offset(new_set, wrapped_offset)
  end
end

original_set = %w(a b c d)
offset = 3
result = permutation_at_offset(original_set, offset)
pp result
puts result == original_set.permutation.to_a[offset]
