class Oystercard

  attr_reader :bal, :entry_stn, :trips

  MAX_BAL = 90
  MIN_FARE = 1

  def initialize(journey_klass = Journey)
    @journey_klass = journey_klass
    @bal = 0
    @trips = Array.new
  end

  def top_up(val)
    raise "Top-up failed: max balance of £#{MAX_BAL}." if bal + val > MAX_BAL
    @bal += val
  end

  def touch_in(entry_stn)
    raise "Insufficient funds" if bal < MIN_FARE
    @current_jny = @journey_klass.new
    @current_jny.start_jny(entry_stn)
  end

  def touch_out(exit_stn)
    @current_jny.end_jny(exit_stn)
    @trips << @current_jny
    deduct
  end

  private

  def deduct(val = MIN_FARE)
    @bal -= val
  end

end
