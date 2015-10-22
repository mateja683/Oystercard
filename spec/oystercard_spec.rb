require 'oystercard'

describe Oystercard do

  context '#intialize' do
    it 'sets a balance of zero' do
      expect(subject.balance).to eq 0
    end
  end

  context '#top_up' do
    it 'allows user to add balance' do
      expect{subject.top_up(10)}.to change(subject, :balance).by(10)
    end
  end

end
