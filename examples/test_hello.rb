$: << File.dirname(__FILE__)
$: << File.dirname(__FILE__) + "/../lib"

require "rubygems"
require "test/unit"
require "hello"
require "assert_equal_with_highlighting"

class TestHello < Test::Unit::TestCase
  include AssertEqualWithHighlighting::InstanceMethods
  
  def test_world
    hello = Hello.new("world")
    assert_equal "Hello, world!", hello.to_s, "World should be greeted"
  end
  
  def test_multiple_targets
    hello = Hello.new("Bob", "Charlie", "Alice")
    assert_equal ["Alice", "Bob", "Charlie"], hello.targets, "Targets should be sorted"
  end
end
