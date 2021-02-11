require 'journey'

class OysterCard
  attr_reader :balance

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  def initialize(balance = 0)
    @maximum_balance = MAXIMUM_BALANCE
    @minimum_balance = MINIMUM_BALANCE
    @balance = balance
    @journey = Journey.new
  end

  def top_up(amount)
    max_balance_error(amount)
    @balance += amount
  end

  def touch_in(station)
    
    min_balance_error
    @journey.startjourney(station)
  end

  def touch_out(station)
    deduct(@journey.fare_out)
    @journey.endjourney(station)
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
