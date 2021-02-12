require 'journey'

class OysterCard
  attr_reader :balance

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  def initialize(balance = 0,journey_log = JourneyLog.new)
    @maximum_balance = MAXIMUM_BALANCE
    @minimum_balance = MINIMUM_BALANCE
    @balance = balance
    @journey = Journey.new
    @journey_log = journey_log
  end

  def top_up(amount)
    max_balance_error(amount)
    @balance += amount
  end

  def touch_in(station)
    deduct(@journey.penalty(@exit_station))
    min_balance_error
    @journey = @journey.new
    @journey.startjourney(station)
  end

  def touch_out(station)
    @journey_log.add_journey(@journey)
    @journey.endjourney(station)
    deduct(@journey.fare)
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
