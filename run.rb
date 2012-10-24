$LOAD_PATH << File.dirname(__FILE__) + '/lib'
require 'inflector'

module Inflector
  puts singularize('perspectives')
end


