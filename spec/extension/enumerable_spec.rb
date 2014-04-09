require 'spec_helper'

describe Enumerable do
    KeyValue = Struct.new(:key, :value) do
    def <=> (other)
      self.key <=> other.key
    end
  end

  let (:array) { [KeyValue.new(1, 1), KeyValue.new(1, 2), KeyValue.new(1, 3), KeyValue.new(1, 4), KeyValue.new(0, 10)] }
  let (:expect) { [KeyValue.new(0, 10), KeyValue.new(1, 1), KeyValue.new(1, 2), KeyValue.new(1, 3), KeyValue.new(1, 4)] }

  describe "#stable_sort_by (Array)" do
    it 'sorts stably' do
      ['a', 'c', 'bd', 'fe', 'b'].sort_by { |x| x.length }.should_not eq ['a', 'c', 'b', 'bd', 'fe']
      ['a', 'c', 'bd', 'fe', 'b'].stable_sort_by { |x| x.length }.should eq ['a', 'c', 'b', 'bd', 'fe']
      ['a', 'c', 'bd', 'fe', 'b'].stable_sort_by.is_a?(Enumerator).should be_true
    end
  end

  describe "#stable_sort_by (Enumerator)" do
    it 'sorts stably' do
      ['a', 'c', 'bd', 'fe', 'b'].each.sort_by { |x| x.length }.should eq ['a', 'c', 'b', 'fe', 'bd']
      ['a', 'c', 'bd', 'fe', 'b'].each.stable_sort_by { |x| x.length }.should eq ['a', 'c', 'b', 'bd', 'fe']
      ['a', 'c', 'bd', 'fe', 'b'].each.stable_sort_by.is_a?(Enumerator).should be_true
    end
  end

  describe "#stable_sort (Array)" do
    it 'sorts stably' do
      array.sort.to_s.should_not eq expect.to_s
      array.stable_sort.to_s.should eq expect.to_s
    end
  end

  describe "#stable_sort (Enumerator)" do
    it 'sorts stably' do
      array.each.sort.to_s.should_not eq expect.to_s
      array.each.stable_sort.to_s.should eq expect.to_s
    end
  end
end

