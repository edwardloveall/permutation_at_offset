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
    indexes = set.size.downto(2).map do |size|
      permutation_count = factorial(size)
      wrapped_offset = offset % permutation_count
      section_size = factorial(size - 1)
      wrapped_offset / section_size
    end
    new_set = set.dup
    indexes.map { |i| new_set.delete_at(i) } + new_set
  end

  def factorial(n)
    Math.gamma(n + 1)
  end
end
