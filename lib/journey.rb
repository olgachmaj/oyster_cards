require 'oyster_card'
class Journey
  attr_reader :journey, :journey_history, :entry_station, :exit_station
  def initialize
    @journey = false
    @journey_history = []
  end

  def startjourney(station)
    @journey = true
    return if station == nil
    @entry_station = station
    @entry_zone = station.zone
  end

  def endjourney(station)
    @journey = false
    @exit_station = station
    store_journey
  end

  def store_journey
    @journey_history << {entry_station: @entry_station, exit_station: @exit_station}
  end

  def penalty(station)
    return 6 if station == nil
  end

  def fare
    return 6 if @entry_station == nil
    [@exit_station.zone, @entry_station.zone].sort.inject(:-)
  end

  def new
    Journey.new
  end


end
