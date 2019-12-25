class Permutation
  attr_reader :set

  def initialize(set)
    @set = set
  end

  def [](offset)
    permutation_at_offset(set, offset)
  end

  private

  def permutation_at_offset(set, offset)
    if set.size == 1
      set
    else
      result = []
      permutation_count = Math.gamma(set.size + 1).to_i
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
end
