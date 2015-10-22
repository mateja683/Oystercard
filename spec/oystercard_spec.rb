require 'oystercard'

describe Oystercard do

  context '#intialize' do

    it 'sets a balance of zero' do
      expect(subject.balance).to eq 0
    end

  end

end
