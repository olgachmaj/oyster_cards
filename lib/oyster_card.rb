class OysterCard
  attr_reader :balance
  MAXIMUM_BALANCE = 90
  def initialize(balance = 0)
    @maximum_balance = MAXIMUM_BALANCE
    @balance = balance
  end

  def top_up(amount)
    max_balance_error(amount)
    @balance += amount
  end

  private

  def max_balance_error(amount)
    fail 'Card balance at maximum.' if (@balance + amount) > @maximum_balance

  end

end
