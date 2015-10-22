class Oystercard

  attr_reader :bal, :entry_stn, :trips

  MAX_BAL = 90

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
    raise "Insufficient funds" if bal < Journey::MIN_FARE
    deduct unless @current_jny.nil?
    current_jny.start_jny(entry_stn)
  end

  def touch_out(exit_stn)
    current_jny.end_jny(exit_stn)
    @trips << @current_jny
    deduct
    @current_jny = nil
  end

  private

  def deduct
    @bal -= @current_jny.fare
  end

  def current_jny
    @current_jny ? @current_jny : (@current_jny =  @journey_klass.new)
  end

end
