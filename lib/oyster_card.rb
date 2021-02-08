class OysterCard
  attr_reader :balance, :journey
  alias :in_journey? :journey

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  def initialize(balance = 0)
    @maximum_balance = MAXIMUM_BALANCE
    @minimum_balance = MINIMUM_BALANCE
    @balance = balance
    @journey = false
  end

  def top_up(amount)
    max_balance_error(amount)
    @balance += amount
  end

  def deduct(fare)
    @balance -= fare
  end

  def touch_in
    min_balance_error
    @journey = true
  end

  def touch_out
    @journey = false
  end

  private

  def max_balance_error(amount)
    fail "Cannot top up beyond £#{@maximum_balance}." if (@balance + amount) > @maximum_balance

  end

  def min_balance_error
    fail "Insufficient funds." if @balance < @minimum_balance

  end

end
