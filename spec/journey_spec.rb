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
end
