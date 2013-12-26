# StableSort [![Build Status](https://travis-ci.org/awakia/ruby_stable_sort.png)](https://travis-ci.org/awakia/ruby_stable_sort)

Add `stable_sort` and `stable_sort_by` to Array and Enumerator.

## Installation

Add this line to your application's Gemfile:

    gem 'stable_sort'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install stable_sort

## Usage

```
['a', 'c', 'bd', 'fe', 'b'].sort_by { |x| x.length }
# => ["a", "c", "b", "fe", "bd"]


['a', 'c', 'bd', 'fe', 'b'].stable_sort_by { |x| x.length }
# => ["a", "c", "b", "bd", "fe"]
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
