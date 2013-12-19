require 'spec_helper'

describe Enumerator do
  describe "#stable_sort_by" do
    it 'sorts stably' do
      ['a', 'c', 'bd', 'fe', 'b'].each.sort_by { |x| x.length }.should_not eq ['a', 'c', 'b', 'bd', 'fe'].each
      ['a', 'c', 'bd', 'fe', 'b'].each.stable_sort_by { |x| x.length }.should eq ['a', 'c', 'b', 'bd', 'fe']
    end
  end

  describe "#stable_sort" do
    it 'sorts' do
      ['a', 'c', 'bd', 'fe', 'b'].each.stable_sort.should eq ['a', 'b', 'bd', 'c', 'fe']
    end
  end
end

