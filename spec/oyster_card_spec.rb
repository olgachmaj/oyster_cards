# frozen_string_literal: true

require 'oyster_card'

describe OysterCard do
  let(:station) { double :station }
  let(:entry_station) { double :station}
  let(:exit_station) { double :station}

  test_top_up = 7
  test_fare = 1
  # checking if oystercard has the method of balance
  it { is_expected.to respond_to :balance }
  it { is_expected.to respond_to :touch_in }
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

  it 'should throw error when journey attempted with under minimum balance' do
    min_bal = OysterCard::MINIMUM_BALANCE
    expect { subject.touch_in(entry_station) }.to raise_error 'Insufficient funds.'
  end

  it 'touch_out should deduct fare amount from balance' do
    subject.top_up(test_top_up)
    subject.touch_in(:station)
    expect { subject.touch_out(exit_station) }.to change { subject.balance }.by(-test_fare)
  end

  it 'touch_in should deduct penalty if @exit_station == nil' do
    subject.top_up(test_top_up)
    expect { subject.touch_in(exit_station) }.to change { subject.balance }.by(-6)
  end

  it 'touch_out should deduct penalty if @entry_station == nil' do
    subject.top_up(test_top_up)
    expect { subject.touch_out(exit_station) }.to change { subject.balance }.by(-6)
  end


end
