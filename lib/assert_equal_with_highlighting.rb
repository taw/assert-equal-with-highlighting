require 'test/unit'
require 'diff/lcs'

module AssertEqualWithHighlighting
  class MockLiteral
    def initialize(str)
      @str = str
    end
    def to_s
      @str
    end
    def inspect
      @str
    end
  end

  module InstanceMethods
    def assert_equal(expected, actual, message=nil)
      if expected == actual
        assert true
      else
        full_message = build_highlighted_message(expected, actual, message)
        assert_block(full_message) { false }
      end
    end

    def assert_dom_equal(expected, actual, message=nil)
      clean_backtrace do
        expected_dom = HTML::Document.new(expected).root
        actual_dom   = HTML::Document.new(actual).root
        if expected_dom == actual_dom
          assert true
        else
          full_message = build_highlighted_message(expected_dom.to_s, actual_dom.to_s, message)
          assert_block(full_message) { false }
        end
      end
    end
  
  private

    def build_highlighted_message(expected, actual, message)
      expected_hl = ""
      actual_hl = ""

      ei = expected.inspect.scan(/\d+|[a-zA-Z]+|./m)
      ai = actual.inspect.scan(/\d+|[a-zA-Z]+|./m)

      Diff::LCS.sdiff(ei, ai).each{|cc|
        if cc.old_element == cc.new_element
          expected_hl << cc.old_element
          actual_hl << cc.new_element
        else
          expected_hl << "\e[41m" + cc.old_element + "\e[0m" if cc.old_element
          actual_hl << "\e[42m" + cc.new_element + "\e[0m" if cc.new_element
        end
      }
      # Optimize ANSI output
      expected_hl.gsub!("\e\[0m\e[41m", "")
      actual_hl.gsub!("\e[0m\e[42m", "")

      expected_hl = AssertEqualWithHighlighting::MockLiteral.new(expected_hl)
      actual_hl = AssertEqualWithHighlighting::MockLiteral.new(actual_hl)
      full_message = build_message(message, <<EOT, expected_hl, actual_hl)
<?> expected but was
<?>.
EOT
    end
  end
end
