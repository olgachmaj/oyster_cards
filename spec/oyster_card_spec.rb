require 'oyster_card'

describe OysterCard do
  #checking if oystercard has the method of balance
  it { is_expected.to respond_to :balance }

  #checking that balance returns the balance
  it 'has default balance of 0 when new' do
  expect(subject.balance).to eq 0
  end

  #checking if oytercard has the method topup
  it { is_expected.to respond_to(:top_up).with(1).argument }

  #we want to topup the card with an amount and see that the balance of the card has been updated with amount
  it 'top_up oystercard with amount and check balance' do
    current_balance = subject.balance
    subject.top_up(amount = 5)
    expect(subject.balance).to eq current_balance + amount
  end
end
