# StableSort [![Build Status](https://travis-ci.org/awakia/ruby_stable_sort.png)](https://travis-ci.org/awakia/ruby_stable_sort) [![Coverage Status](https://coveralls.io/repos/awakia/ruby_stable_sort/badge.png)](https://coveralls.io/r/awakia/ruby_stable_sort)

Add `stable_sort` and `stable_sort_by` to Array and Enumerator.

## Installation

Add this line to your application's Gemfile:

    gem 'stable_sort'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install stable_sort

## Usage

stable_sort

```
KeyValue = Struct.new(:key, :value) do
  def <=> (other)
    self.key <=> other.key
  end
end

[KeyValue.new(1, 1), KeyValue.new(1, 2), KeyValue.new(1, 3), KeyValue.new(1, 4), KeyValue.new(0, 10)].sort
# => [#<struct KeyValue key=0, value=10>, #<struct KeyValue key=1, value=3>, #<struct KeyValue key=1, value=2>, #<struct KeyValue key=1, value=4>, #<struct KeyValue key=1, value=1>]

[KeyValue.new(1, 1), KeyValue.new(1, 2), KeyValue.new(1, 3), KeyValue.new(1, 4), KeyValue.new(0, 10)].stable_sort
# => [#<struct KeyValue key=0, value=10>, #<struct KeyValue key=1, value=1>, #<struct KeyValue key=1, value=2>, #<struct KeyValue key=1, value=3>, #<struct KeyValue key=1, value=4>]
```

stable_sort_by

```
['a', 'c', 'bd', 'fe', 'b'].sort_by { |x| x.length }
# => ["a", "c", "b", "fe", "bd"]

['a', 'c', 'bd', 'fe', 'b'].stable_sort_by { |x| x.length }
# => ["a", "c", "b", "bd", "fe"]
```

Currently, stable_sort gem do not take block. If you needed, please send a pull request :)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
