class Journey

  attr_reader :entry_stn, :exit_stn

  def start_jny(entry_stn)
    @entry_stn = entry_stn
  end

  def end_jny(exit_stn)
    @exit_stn = exit_stn
  end

end
