require 'oystercard'

describe Oystercard do

  let(:max_bal){ Oystercard::MAX_BAL }
  let(:min_fare){ Oystercard::MIN_FARE }
  let(:stn) { double:station }

  context '#intialize' do
    it 'sets a balance of zero' do
      expect(subject.bal).to eq 0
    end

    it 'sets @trips to an empty array' do
      expect(subject.trips).to be_empty
    end
  end

  context '#top_up' do
    it 'allows user to add balance' do
      expect{ subject.top_up(10) }.to change(subject, :bal).by(10)
    end

    it 'prevents top up beyond max balance' do
      error = "Top-up failed: max balance of £#{max_bal}."
      subject.top_up(max_bal)
      expect{ subject.top_up(1) }.to raise_error error
    end
  end

  context "#deduct" do
    it 'allows fare to be deducted' do
      subject.top_up(10)
      expect{ subject.deduct(3) }.to change(subject, :bal).by(-3)
    end
  end

  context '#touch_in' do
    it 'checks for min bal' do
      subject.top_up(min_fare - 1)
      expect{ subject.touch_in(stn) }.to raise_error "Insufficient funds"
    end

    it 'stores the entry station' do
      subject.top_up(min_fare)
      subject.touch_in(stn)
      expect(subject.entry_stn).to eq (stn)
    end
  end

  context '#touch_out' do
    it 'deducts the minimum fare' do
      subject.top_up(min_fare)
      expect{ subject.touch_out(stn) }.to change(subject, :bal).by(-min_fare)
    end

    it 'stores the completed trip on touch out' do
      subject.top_up(min_fare)
      subject.touch_in(stn)
      subject.touch_out(stn)
      expect(subject.trips).to include({:entry_stn => stn, :exit_stn => stn})
    end

  end


end
