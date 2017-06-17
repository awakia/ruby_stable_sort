# Monkey-patch the default sorts to ensure that they are unstable.  We
# do that because sort is stable in some Ruby implementations
# (e.g. MRI >= 2.2 on Linux).  Tests run under those implementations
# could pass even if this library were broken.
#
# We monkey-patch all sort methods: Even though in MRI some sort
# methods use other sort methods (for example, Enumerable#sort uses
# Array#sort), some of those bindings are static, and others dynamic.
# A minimal monkey-patch would bind the tests tightly to the Ruby
# implementation, making them fragile.  Patching all sort methods
# makes the test more resiliant when the implementation changes.

RSpec.configure do |c|
  c.before do
    # To make tests reproducible, set the random number seed before
    # each test.  Since the tests depend upon sorting relatively short
    # lists, and noticing whether the sorted lists are stably sorted
    # or not, occasional false test failures result.  There's nothing
    # special about this seed: it's just one that caused all the tests
    # to be reproducible.
    #
    # This is a bit of a hack, dependent upon the random number
    # generator in a given implementation.
    #
    # An alternative to this is to make the test arrays large enough
    # that false negatives are unlikely enough to not be a problem.
    # That would be less of a hack, but a larger change to the
    # existing tests.
    Random.srand(10)
  end
end

class Array

  original_sort_by = instance_method(:sort_by)
  define_method(:sort_by) do |*args, &block|
    return to_enum(:sort_by) unless block
    original_sort_by.bind(self).call do |o|
      [block.call(o), rand]
    end
  end

  original_sort_by_bang = instance_method(:sort_by!)
  define_method(:sort_by!) do |*args, &block|
    return to_enum(:sort_by!) unless block
    original_sort_by_bang.bind(self).call do |o|
      [block.call(o), rand]
    end
  end

  original_sort = instance_method(:sort)
  define_method(:sort) do |*args, &block|
    if block_given?
      original_sort.bind(self).call do |a, b|
        [yield(a, b), rand]
      end
    else
      original_sort.bind(self).call do |a, b|
        [a, rand] <=> [b, rand]
      end
    end
  end

  original_sort_bang = instance_method(:sort!)
  define_method(:sort!) do
    if block_given?
      original_sort_bang.bind(self).call do |a, b|
        [yield(a, b), rand]
      end
    else
      original_sort_bang.bind(self).call do |a, b|
        [a, rand] <=> [b, rand]
      end
    end
  end
  
end

module Enumerable

  original_sort = instance_method(:sort)
  define_method(:sort) do
    if block_given?
      original_sort.bind(self).call do |a, b|
        [yield(a, b), rand]
      end
    else
      original_sort.bind(self).call do |a, b|
        [a, rand] <=> [b, rand]
      end
    end
  end

  original_sort_by = instance_method(:sort_by)
  define_method(:sort_by) do |&block|
    return to_enum(:sort_by) unless block
    original_sort_by.bind(self).call do |o|
      [block.call(o), rand]
    end
  end

end
