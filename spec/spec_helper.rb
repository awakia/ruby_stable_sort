require 'coveralls'
Coveralls.wear!

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'stable_sort'

glob = File.join(File.dirname(__FILE__), "support/**/*.rb")
Dir[glob].sort.each do |path|
  require path
end
