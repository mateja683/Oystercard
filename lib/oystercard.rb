class Oystercard

  attr_reader :bal

  MAX_BAL = 90

  def initialize
    @bal = 0
  end

  def top_up(val)
    raise "Top-up failed: max balance of £#{MAX_BAL}." if bal + val > MAX_BAL
    @bal += val
  end

end
