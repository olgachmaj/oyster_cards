# frozen_string_literal: true

require 'oyster_card'

describe OysterCard do
  let(:station) { double :station }
  let(:entry_station) { double :station}
  let(:exit_station) { double :station}

  test_top_up = 5
  test_fare = 2
  # checking if oystercard has the method of balance
  it { is_expected.to respond_to :balance }
  it { is_expected.to respond_to :touch_in }
  it { is_expected.to respond_to :in_journey? }
  it { is_expected.to respond_to :touch_out }

  # checking that balance returns the balance
  it 'has default balance of 0 when new' do
    expect(subject.balance).to eq 0
  end

  # checking if oytercard has the method topup
  it { is_expected.to respond_to(:top_up).with(1).argument }
  #  it { is_expected.to respond_to(:deduct).with(1).argument }

  # we want to topup the card with an amount and see that the balance of the card has been updated with amount
  it 'top_up oystercard with amount and check balance' do
    current_balance = subject.balance
    subject.top_up(amount = test_top_up)
    expect(subject.balance).to eq current_balance + amount
  end
  it 'should throw error when topped up beyond £90' do
    max_bal = OysterCard::MAXIMUM_BALANCE
    subject.top_up(max_bal)
    expect { subject.top_up(1) }.to raise_error "Cannot top up beyond £#{max_bal}."
  end
  # it 'money is deducted from balance' do
  #  subject.top_up(10)
  #  current_balance = subject.balance
  #  subject.deduct(amount = test_top_up)
  #  expect(subject.balance).to eq current_balance - amount
  # end
  it 'should throw error when journey attempted with under minimum balance' do
    min_bal = OysterCard::MINIMUM_BALANCE
    expect { subject.touch_in(entry_station) }.to raise_error 'Insufficient funds.'
  end
  it 'should have journey status of false when new' do
    expect(described_class.new.in_journey?).to eq false
  end

  it 'touch_out should deduct fare amount from balance' do
    subject.top_up(test_top_up)
    expect { subject.touch_out(test_fare, exit_station) }.to change { subject.balance }.by(-test_fare)
  end

  describe 'journey test' do
    before(:each) { subject.top_up(test_top_up) }
    it 'should have in journey status of true after touch_in(station)' do
      subject.touch_in(entry_station)
      expect(subject.in_journey?).to eq true
    end
    it 'should have in journey status of false after touch_out' do
      subject.touch_in(entry_station)
      subject.touch_out(test_fare, exit_station)
      expect(subject.in_journey?).to eq false
    end
    it 'remember the touch in location' do
      subject.touch_in(entry_station)
      expect(subject.entry_station).to eq entry_station
    end

    it 'forgets the entry_station on touch out' do
      subject.touch_in(entry_station)
      subject.touch_out(test_fare, exit_station)
      expect(subject.entry_station).to eq nil
    end

    it 'displays trip history' do
      subject.touch_in(entry_station)
      subject.touch_out(test_fare, exit_station)
      expect(subject.journey_history). to eq [entry_station, exit_station]
    end

    it 'stores exit station' do
      subject.touch_in(entry_station)
      subject.touch_out(test_fare, exit_station)
      expect(subject.exit_station).to eq exit_station
    end
  end
end
