class Present
  include Enumerable

  def initialize(value)
    @value = value
  end

  def unwrap_or(_, &block)
    unwrap(&block)
  end

  def present(&block)
    block.call(unwrap)
    self
  end

  def blank(&ignored)
    self
  end

  def each(&block)
    unwrap(&block)
    [unwrap]
  end

  def unwrap
    if block_given?
      yield @value
    else
      @value
    end
  end

  def present?
    true
  end

  def blank?
    false
  end
end

class Blank
  include Enumerable

  def unwrap
    raise IndexError.new("Blank has no value")
  end

  def unwrap_or(default)
    default
  end

  def present
    self
  end

  def blank(&block)
    block.call
    self
  end

  def each
    []
  end

  def present?
    false
  end

  def blank?
    true
  end
end
