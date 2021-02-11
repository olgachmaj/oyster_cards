require 'oyster_card'
class Journey
  attr_reader :journey, :journey_history, :entry_station, :exit_station
  def initialize
    @journey = false
    @journey_history = []
  end

  def startjourney(station)
    @journey = true
    @entry_station = station
  end

  def endjourney(station)
    @journey = false
    @exit_station = station
    store_journey
  end

  def store_journey
    @journey_history << {entry_station: @entry_station, exit_station: @exit_station}
  end

  def fare(station = nil)
    return 6 if station == nil
    1
  end

  def new
    Journey.new
  end


end
