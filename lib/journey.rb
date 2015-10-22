class Journey

  MIN_FARE = 1
  PEN_FARE = 6

  attr_reader :entry_stn, :exit_stn, :fare

  def initialize
    @fare = PEN_FARE
  end

  def start_jny(entry_stn)
    @entry_stn = entry_stn
  end

  def end_jny(exit_stn)
    @exit_stn = exit_stn
    @fare = MIN_FARE if @entry_stn
  end

end
