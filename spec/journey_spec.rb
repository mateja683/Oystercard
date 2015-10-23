require 'journey'

describe Journey do

  context '#start_jny' do
    it 'stores the entry station' do
      subject.start_jny(:stn)
      expect(subject.entry_stn).to eq (:stn)
    end

  end

  context '#end_jny' do

    it 'stoares the exit station' do
      subject.end_jny(:stn)
      expect(subject.exit_stn).to eq (:stn)
    end

  end

  context '#fare' do

    it 'calculates min fare for a valid journey' do
      subject.start_jny(:stn)
      subject.end_jny(:stn)
      expect(subject.fare).to eq(Journey::MIN_FARE)
    end

    it 'calculates penalty fare if no entry_stn' do
      subject.end_jny(:stn)
      expect(subject.fare).to eq(Journey::PEN_FARE)
    end
  end

end
