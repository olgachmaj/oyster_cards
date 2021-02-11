require 'station'

describe Station do
  subject(:station) { described_class.new("West Croydon", 4) }

  it 'expect the station to return name' do
    expect(subject.name).to eq("West Croydon")
  end

  it 'expect the station to return name' do
    expect(subject.zone).to eq(4)
  end

end
