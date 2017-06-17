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
      expect(['a', 'c', 'bd', 'fe', 'b'].stable_sort_by { |x| x.length }).to eq ['a', 'c', 'b', 'bd', 'fe']
      expect(['a', 'c', 'bd', 'fe', 'b'].stable_sort_by.is_a?(Enumerator)).to be true
    end
  end

  describe "#stable_sort_by (Enumerator)" do
    it 'sorts stably' do
      expect(['a', 'c', 'bd', 'fe', 'b'].each.stable_sort_by { |x| x.length }).to eq ['a', 'c', 'b', 'bd', 'fe']
      expect(['a', 'c', 'bd', 'fe', 'b'].each.stable_sort_by.is_a?(Enumerator)).to be true
    end
  end

  describe "#stable_sort (Array)" do
    it 'sorts stably' do
      expect(array.stable_sort.to_s).to eq expectation.to_s
    end
  end

  describe "#stable_sort (Enumerator)" do
    it 'sorts stably' do
      expect(array.each.stable_sort.to_s).to eq expectation.to_s
    end
  end

  # Ensure that Enumerable's built-in sorts are unstable.  In some
  # Ruby implementations, sorts are stable.  These tests force the
  # built-in sorts to be unstable, which we ensure here.
  describe "built-in sort" do

    describe "Enumerable#sort_by" do
      it "is unstable" do
        unsorted = ['a', 'c', 'bd', 'fe', 'b'].each
        enum = unsorted.sort_by
        sorted = enum.with_index { |e, _i| e.length }
        expect(enum).to be_an(Enumerator)
        expect(sorted.to_a).not_to eq ['a', 'c', 'b', 'bd', 'fe']
      end
    end

    describe "Enumerable#sort_by with block" do
      it "is unstable" do
        unsorted = ['a', 'c', 'bd', 'fe', 'b'].each
        sorted = unsorted.sort_by { |e| e.length }
        expect(sorted).not_to eq ['a', 'c', 'b', 'bd', 'fe']
      end
    end

    describe "Enumerable#sort" do
      it "is unstable" do
        unsorted = array.each
        sorted = unsorted.sort
        expect(sorted.to_s).not_to eq expectation.to_s
      end
    end

    describe "Enumerable#sort with block" do
      it "is unstable" do
        unsorted = array.each
        sorted = unsorted.sort do |a, b|
          a.length <=> b.length
        end
        expect(sorted.to_s).not_to eq expectation.to_s
      end
    end
    
  end
  
end
