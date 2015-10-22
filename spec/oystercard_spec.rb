require 'oystercard'

describe Oystercard do

  let(:max_bal){ Oystercard::MAX_BAL }
  let(:min_fare){ Oystercard::MIN_FARE }

  context '#intialize' do
    it 'sets a balance of zero' do
      expect(subject.bal).to eq 0
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
      expect{ subject.touch_in }.to raise_error "Insufficient funds"
    end
  end

  context '#touch_out' do
    it 'deducts the minimum fare' do
      subject.top_up(min_fare)
      expect{ subject.touch_out }.to change(subject, :bal).by(-min_fare)
    end
  end
end
