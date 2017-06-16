require 'spec_helper'

describe Enumerable do
  
  KeyValue = Struct.new(:key, :value) do
    def <=> (other)
      self.key <=> other.key
    end
  end

  let (:array) { [KeyValue.new(1, 1), KeyValue.new(1, 2), KeyValue.new(1, 3), KeyValue.new(1, 4), KeyValue.new(0, 10)] }
  let (:expectation) { [KeyValue.new(0, 10), KeyValue.new(1, 1), KeyValue.new(1, 2), KeyValue.new(1, 3), KeyValue.new(1, 4)] }

  describe "#stable_sort_by (Array)" do
    it 'sorts stably' do
      expect(['a', 'c', 'bd', 'fe', 'b'].sort_by { |x| x.length }).not_to eq ['a', 'c', 'b', 'bd', 'fe']
      expect(['a', 'c', 'bd', 'fe', 'b'].stable_sort_by { |x| x.length }).to eq ['a', 'c', 'b', 'bd', 'fe']
      expect(['a', 'c', 'bd', 'fe', 'b'].stable_sort_by.is_a?(Enumerator)).to be true
    end
  end

  describe "#stable_sort_by (Enumerator)" do
    it 'sorts stably' do
      expect(['a', 'c', 'bd', 'fe', 'b'].each.sort_by { |x| x.length }).to eq ['a', 'c', 'b', 'fe', 'bd']
      expect(['a', 'c', 'bd', 'fe', 'b'].each.stable_sort_by { |x| x.length }).to eq ['a', 'c', 'b', 'bd', 'fe']
      expect(['a', 'c', 'bd', 'fe', 'b'].each.stable_sort_by.is_a?(Enumerator)).to be true
    end
  end

  describe "#stable_sort (Array)" do
    it 'sorts stably' do
      expect(array.sort.to_s).not_to eq expectation.to_s
      expect(array.stable_sort.to_s).to eq expectation.to_s
    end
  end

  describe "#stable_sort (Enumerator)" do
    it 'sorts stably' do
      expect(array.each.sort.to_s).not_to eq expectation.to_s
      expect(array.each.stable_sort.to_s).to eq expectation.to_s
    end
  end
end

