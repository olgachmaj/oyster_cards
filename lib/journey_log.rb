require 'journey'
require 'oyster_card'

class JourneyLog

  def initialize
    @journey_storage = []
  end

  def add_journey(journey)
    @journey_storage << journey
  end
  
end
