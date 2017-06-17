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

  # Ensure that Array's built-in sorts are unstable.  In some Ruby
  # implementations, sorts are stable.  These tests force the built-in
  # sorts to be unstable, which we ensure here.
  describe "built-in sort" do

    describe "Array#sort" do
      it "is unstable" do
        sorted = array.sort
        expect(sorted.to_s).not_to eq expectation.to_s
      end
    end

    describe "Array#sort with block" do
      it "is unstable" do
        sorted = array.sort do |a, b|
          a.length <=> b.length
        end
        expect(sorted.to_s).not_to eq expectation.to_s
      end
    end

    describe "Array#sort!" do
      it "is unstable" do
        sorted = array.dup
        sorted.sort!
        expect(sorted.to_s).not_to eq expectation.to_s
      end
    end

    describe "Array#sort! with block" do
      it "is unstable" do
        sorted = array.dup
        sorted.sort! do |a, b|
          a.length <=> b.length
        end
        expect(sorted.to_s).not_to eq expectation.to_s
      end
    end

    describe "Array#sort_by" do
      it "is unstable" do
        unsorted = ['a', 'c', 'bd', 'fe', 'b']
        enum = unsorted.sort_by
        sorted = enum.with_index { |e, _i| e.length }
        expect(enum).to be_an(Enumerator)
        expect(sorted.to_a).not_to eq ['a', 'c', 'b', 'bd', 'fe']
      end
    end

    describe "Array#sort_by with block" do
      it "is unstable" do
        unsorted = ['a', 'c', 'bd', 'fe', 'b']
        sorted = unsorted.sort_by { |e| e.length }
        expect(sorted).not_to eq ['a', 'c', 'b', 'bd', 'fe']
      end
    end

    describe "Array#sort_by!" do
      it "is unstable" do
        sorted = ['a', 'c', 'bd', 'fe', 'b'].dup
        enum = sorted.sort_by!
        enum.with_index { |e, _i| e.length }
        expect(enum).to be_an(Enumerator)
        expect(sorted.to_a).not_to eq ['a', 'c', 'b', 'bd', 'fe']
      end
    end

    describe "Array#sort_by! with block" do
      it "is unstable" do
        sorted = ['a', 'c', 'bd', 'fe', 'b'].dup
        sorted.sort_by! { |e| e.length }
        expect(sorted).not_to eq ['a', 'c', 'b', 'bd', 'fe']
      end
    end
    
  end

end

