if RAILS_ENV =~ /\Atest/
  require "assert_equal_with_highlighing"
  require 'action_controller/test_case'
  class ActiveSupport::TestCase
    include AssertEqualWithHighlighting::InstanceMethods
  end
end
