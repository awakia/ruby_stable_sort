class Array
  def stable_sort_by
    sort_by.with_index{ |e, index| [yield(e), index] }
  end

  def stable_sort_by!
    sort_by!.with_index{ |e, index| [yield(e), index] }
  end

  def stable_sort
    stable_sort_by { |x| x }
  end

  def stable_sort!
    stable_sort_by! { |x| x }
  end
end
