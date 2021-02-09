# frozen_string_literal: true

class OysterCard
  attr_reader :balance, :journey, :entry_station, :exit_station, :journey_history
  alias in_journey? journey

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  def initialize(balance = 0)
    @maximum_balance = MAXIMUM_BALANCE
    @minimum_balance = MINIMUM_BALANCE
    @balance = balance
    @journey = false
    @journey_history = []
  end

  def top_up(amount)
    max_balance_error(amount)
    @balance += amount
  end

  def touch_in(station)
    min_balance_error
    @journey = true
    @journey_history << @entry_station = station
  end

  def touch_out(fare, station)
    deduct(fare)
    @journey = false
    @journey_history << @exit_station = station
    @entry_station = nil
  end

  private

  def deduct(fare)
    @balance -= fare
  end

  def max_balance_error(amount)
    if (@balance + amount) > @maximum_balance
      raise "Cannot top up beyond £#{@maximum_balance}."
    end
  end

  def min_balance_error
    raise 'Insufficient funds.' if @balance < @minimum_balance
  end
end
