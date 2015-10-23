require 'oystercard'

describe Oystercard do

  let(:max_bal){ Oystercard::MAX_BAL }
  let(:top_up_error){ Oystercard::TOP_UP_ERROR }
  let(:min_fare_error){ Oystercard::MIN_FARE_ERROR }
  let(:min_fare){ 1 }
  let(:pen_fare){ 6 }

  let(:stn) { double:station }

  let(:jrny){ double('jrny', start_jrny: nil, end_jrny: nil, fare: min_fare) }
  let(:jrny_klass){ double('jrny_klass',new: jrny ) }

  subject { Oystercard.new(jrny_klass) }

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
      subject.top_up(max_bal)
      expect{ subject.top_up(1) }.to raise_error top_up_error
    end
  end

  context '#touch_in' do
    it 'checks for min bal' do
      subject.top_up(min_fare - 1)
      expect{ subject.touch_in(stn) }.to raise_error min_fare_error
    end
    it 'stores an incomplete journey' do
      subject.top_up(min_fare)
      2.times { subject.touch_in(stn) }
      expect(subject.trips.last).to eq(jrny)
    end
    it 'charges for an incomplete journey' do
      subject.top_up(min_fare)
      subject.touch_in(stn)
      allow(jrny).to receive(:fare) {pen_fare}
      expect{ subject.touch_in(stn) }.to change(subject, :bal).by(-pen_fare)
    end
  end

  context '#touch_out' do
    it 'deducts the minimum fare' do
      subject.top_up(min_fare)
      subject.touch_in(stn)
      expect{ subject.touch_out(stn) }.to change(subject, :bal).by(-min_fare)
    end
    it 'stores the completed trip on touch out' do
      subject.top_up(min_fare)
      subject.touch_in(stn)
      subject.touch_out(stn)
      expect(subject.trips.last).to eq(jrny)
    end
  end

end
