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
    @journey_history << {entry_station: @entry_station, exit_station: @exit_station}
  end

  def fare_exit
    if @entry_station == nil ? 6 : 1
  end

  def fare_in
    if @exit_station == nil ? 6 : 1
  end
end
