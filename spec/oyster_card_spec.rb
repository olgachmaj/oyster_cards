require 'oyster_card'

describe OysterCard do
  #checking if oystercard has the method of balance
  it { is_expected.to respond_to :balance }
  it { is_expected.to respond_to :touch_in }
  it { is_expected.to respond_to :in_journey? }
  it { is_expected.to respond_to :touch_out }

  #checking that balance returns the balance
  it 'has default balance of 0 when new' do
  expect(subject.balance).to eq 0
  end

  #checking if oytercard has the method topup
  it { is_expected.to respond_to(:top_up).with(1).argument }
  it { is_expected.to respond_to(:deduct).with(1).argument }

  #we want to topup the card with an amount and see that the balance of the card has been updated with amount
  it 'top_up oystercard with amount and check balance' do
    current_balance = subject.balance
    subject.top_up(amount = 5)
    expect(subject.balance).to eq current_balance + amount
  end
  it 'should throw error when topped up beyond £90' do
    max_bal = OysterCard::MAXIMUM_BALANCE
    subject.top_up(90)
    expect { subject.top_up(1) }.to raise_error "Cannot top up beyond £#{max_bal}."
  end
  it 'money is deducted from balance' do
    subject.top_up(10)
    current_balance = subject.balance
    subject.deduct(amount = 5)
    expect(subject.balance).to eq current_balance - amount
  end
  it 'should have journey status of false when new' do
    expect(described_class.new.in_journey?).to eq false
  end
  it 'should have in journey status of true after touch_in' do
    subject.touch_in
    expect(subject.in_journey?).to eq true
  end
  it 'should have in journey status of false after touch_out' do
    subject.touch_in
    subject.touch_out
    expect(subject.in_journey?).to eq false
  end
end
