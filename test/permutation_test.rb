require "pry"
require "minitest/autorun"
require_relative "../permutation"

class TestPermutation < Minitest::Test
  def test_one_item_permutation
    set = %w(a)
    permutations = Permutation.new(set)

    set.permutation.with_index do |permutation, index|
      assert_equal permutation, permutations[index]
    end
  end

  def test_two_item_permutation
    set = %w(a b)
    permutations = Permutation.new(set)

    set.permutation.with_index do |permutation, index|
      assert_equal permutation, permutations[index]
    end
  end

  def test_three_item_permutation
    set = %w(a b c)
    permutations = Permutation.new(set)

    set.permutation.with_index do |permutation, index|
      assert_equal permutation, permutations[index]
    end
  end

  def test_eight_item_permutation
    set = %w(a b c d e f g h)
    permutations = Permutation.new(set)

    set.permutation.with_index do |permutation, index|
      assert_equal permutation, permutations[index]
    end
  end
end
