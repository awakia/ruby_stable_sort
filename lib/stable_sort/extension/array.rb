class Array
  def stable_sort_by!
    self.sort_by!.with_index{ |e, index| [yield(e), index] }
  end

  def stable_sort!
    self.stable_sort_by! { |x| x }
  end
end
