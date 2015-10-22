class Oystercard

  attr_reader :bal, :entry_stn

  MAX_BAL = 90
  MIN_FARE = 1

  def initialize
    @bal = 0
  end

  def top_up(val)
    raise "Top-up failed: max balance of £#{MAX_BAL}." if bal + val > MAX_BAL
    @bal += val
  end

  def deduct(val = MIN_FARE)
    @bal -= val
  end

  def touch_in(station)
    raise "Insufficient funds" if bal < MIN_FARE
    @entry_stn = station
  end

  def touch_out
    deduct
  end
end
