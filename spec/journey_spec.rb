require 'journey'

describe Journey do
  startstation = "start station"
  endstation = "end station"
  it 'we expect journey to be false by default' do
    expect(subject.journey).to eq false
  end

  it 'when you start journey, journey should be true' do
    subject.startjourney(startstation)
    expect(subject.journey).to eq true
  end

  it 'when you start journey store the station in the entry_station variable' do
    subject.startjourney(startstation)
    expect(subject.entry_station).to eq startstation
  end

  it 'displays trip history' do
    subject.startjourney(startstation)
    subject.endjourney(endstation)
    expect(subject.journey_history).to eq([{:entry_station=>"start station", :exit_station=>"end station"}])
  end

  it 'fines a person if there is no exit station' do
    subject.startjourney(startstation)
    subject.endjourney(nil)
    expect(subject.fare).to eq(6)
  end
end
