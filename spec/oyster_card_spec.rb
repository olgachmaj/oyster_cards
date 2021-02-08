require 'oyster_card'

describe OysterCard do
  #checking if oystercard has the method of balance
  it { is_expected.to respond_to :balance }

  #checking that balance returns the balance
  it 'has default balance of 0 when new' do
  expect(subject.balance).to eq 0
  end
end
