require 'journey'

describe Journey do



  it 'we expect journey to be false by default' do
    expect(subject.journey).to eq false
  end

  it 'when you start journey, journey should be true' do
    entry_station = double()
    allow(entry_station).to receive(:zone){2}
    subject.startjourney(entry_station)
    expect(subject.journey).to eq true
  end

  it 'when you start journey store the station in the entry_station variable' do
    entry_station = double()
    allow(entry_station).to receive(:zone){2}
    subject.startjourney(entry_station)
    expect(subject.entry_station).to eq entry_station
  end

  it 'displays trip history' do
    entry_station = double()
    exit_station = double()
    allow(entry_station).to receive(:zone){2}
    allow(exit_station).to receive(:zone){2}
    subject.startjourney(entry_station)
    subject.endjourney(exit_station)
    expect(subject.journey_history).to eq([{:entry_station=>entry_station, :exit_station=>exit_station}])
  end

  it 'fines a person if there is no exit station' do
    entry_station = double()
    allow(entry_station).to receive(:zone){2}
    subject.startjourney(entry_station)
    subject.endjourney(nil)
    expect(subject.penalty(@exit_station)).to eq(6)
  end
end
