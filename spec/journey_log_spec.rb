require 'oyster_card'
require 'journey'
require 'journey_log'

describe JourneyLog do
  describe '#add_journey' do
    it'adds journey to the journey_storage' do
      journey = double()
      expect(JourneyLog.new.add_journey(journey)).to eq [journey]
    end
  end
end
