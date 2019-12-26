require "benchmark"
require_relative "permutation"
count = 2000

set = %w(a b c d e f g h)
permutation_count = Math.gamma(set.count + 1)
permutations = Permutation.new(set)
offset = permutation_count - 1

Benchmark.bm do |x|
  x.report("ruby: ") do
    count.times do
      set.permutation.with_index do |perm, index|
        break if index == offset
      end
    end
  end
  x.report("new:  ") { count.times { Permutation.new(set)[offset] } }
end
