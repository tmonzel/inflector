require 'test/unit'
require 'inflector'

module Test::Unit
  class TestInflector < TestCase
    include Inflector
    
    def test_singularize
      {"wife" => "wives", "perspective" => "perspectives"}.each do |s, p|
        assert_equal(s, singularize(p))
      end
      
      
    end
  end
end