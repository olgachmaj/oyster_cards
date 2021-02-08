class OysterCard
  attr_reader :balance
  MAXIMUM_BALANCE = 90
  def initialize(balance = 0)
    @maximum_balance = MAXIMUM_BALANCE
    @balance = balance
  end
  def top_up(amount)
    fail 'Card balance at maximum.' if (@balance + amount) > @maximum_balance
    @balance += amount
  end
end
