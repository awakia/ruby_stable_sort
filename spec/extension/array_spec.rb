require 'spec_helper'

describe Array do
  describe "#stable_sort_by" do
    it 'sorts stably' do
      ['a', 'c', 'bd', 'fe', 'b'].sort_by { |x| x.length }.should_not eq ['a', 'c', 'b', 'bd', 'fe']
      ['a', 'c', 'bd', 'fe', 'b'].stable_sort_by { |x| x.length }.should eq ['a', 'c', 'b', 'bd', 'fe']
    end
  end

  describe "#stable_sort_by!" do
    it 'sorts stably' do
      arr = ['a', 'c', 'bd', 'fe', 'b']
      arr.stable_sort_by! { |x| x.length }.should eq ['a', 'c', 'b', 'bd', 'fe']
      arr.should eq ['a', 'c', 'b', 'bd', 'fe']
    end
  end

  describe "#stable_sort" do
    it 'sorts' do
      ['a', 'c', 'bd', 'fe', 'b'].stable_sort.should eq ['a', 'b', 'bd', 'c', 'fe']
    end
  end

  describe "#stable_sort!" do
    it 'sorts' do
      arr = ['a', 'c', 'bd', 'fe', 'b']
      arr.stable_sort!.should eq ['a', 'b', 'bd', 'c', 'fe']
      arr.should eq ['a', 'b', 'bd', 'c', 'fe']
    end
  end
end

