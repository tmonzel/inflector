require 'test/unit'
require 'inflector'

# Include our core extension into the string class
class String
  include Inflector::CoreExtensions::String
end

class TestCoreExtensions < Test::Unit::TestCase
  def test_pluralize
    assert_equal("boys", "boy".pluralize)
  end
  
  def test_singularize
    assert_equal("fruit", "fruits".singularize)
  end
  
  def test_underscore
    assert_equal("hello_my_friend", "helloMyFriend".underscore)
  end
  
  def test_camelize
    assert_equal("setMeFree", "set_me_free".camelize)
  end
  
  def test_pascalize
    assert_equal("SetMeFree", "set_me_free".pascalize)
  end
  
  def test_uncapitalize
    assert_equal("canYou_See", "CanYou_See".uncapitalize)
  end
  
  def test_constantize
    assert_equal(Inflector::CoreExtensions, "Inflector::CoreExtensions".constantize)
  end
end
