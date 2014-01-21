module Enumerable
  def stable_sort_by
    return to_enum(:stable_sort_by) if !block_given?
    sort_by.with_index{ |e, index| [yield(e), index] }
  end
  def stable_sort
    stable_sort_by { |x| x }
  end
end
