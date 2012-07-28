class Hello
  attr_reader :targets
  
  def initialize(*targets)
    @targets = targets
  end
  
  def to_s
    "Hello, #{@targets.join(", ")}!"
  end
end
