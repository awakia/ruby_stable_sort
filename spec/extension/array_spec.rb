require 'spec_helper'

describe Array do
  KeyValue = Struct.new(:key, :value) do
    def <=> (other)
      self.key <=> other.key
    end
  end

  let (:array) { [KeyValue.new(1, 1), KeyValue.new(1, 2), KeyValue.new(1, 3), KeyValue.new(1, 4), KeyValue.new(0, 10)] }
  let (:expectation) { [KeyValue.new(0, 10), KeyValue.new(1, 1), KeyValue.new(1, 2), KeyValue.new(1, 3), KeyValue.new(1, 4)] }

  describe "#stable_sort_by!" do
    it 'sorts stably' do
      arr = ['a', 'c', 'bd', 'fe', 'b']
      expect(arr.stable_sort_by! { |x| x.length }).to eq ['a', 'c', 'b', 'bd', 'fe']
      expect(arr).to eq ['a', 'c', 'b', 'bd', 'fe']
    end
  end

  describe "#stable_sort!" do
    it 'sorts stably' do
      expect(array.stable_sort!.to_s).to eq expectation.to_s
      expect(array.to_s).to eq expectation.to_s
    end
  end
end

