require 'station'

describe Station do
  subject { Station.new(:name, :zone) }

  it 'stores a station name' do
    expect(subject.name).to eq :name
  end

  it 'stores a zone' do
    expect(subject.zone).to eq :zone
  end
end
