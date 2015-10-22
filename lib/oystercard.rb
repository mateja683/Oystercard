class Oystercard

  attr_reader :bal

  MAX_BAL = 90
  MIN_FARE = 1

  def initialize
    @bal = 0
  end

  def top_up(val)
    raise "Top-up failed: max balance of £#{MAX_BAL}." if bal + val > MAX_BAL
    @bal += val
  end

  def deduct(val)
    @bal -= val
  end

  def touch_in
    raise "Insufficient funds" if bal < MIN_FARE
  end
end
