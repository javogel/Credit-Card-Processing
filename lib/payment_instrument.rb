# frozen_string_literal: true

#Base Payment Instrument
class PaymentInstrument
  attr_reader :name, :balance, :account_number, :limit

  def initialize(args)
    @name = args[:name]
    @account_number = args[:account_number]
    @account_valid = valid_account_number?(args[:account_number])
    @limit = clean_amount(args[:limit])
    @balance = starting_balance
  end

  def charge(a)
    amount = clean_amount(a)
    @balance += amount if valid_charge?(amount)
  end

  def credit(a)
    amount = clean_amount(a)
    @balance -= amount if valid_credit?(amount)
  end

  def printable_balance
    @balance.is_a?(Integer) ? '$' + @balance.to_s : @balance
  end

  private

  def valid_account_number?(_num)
    true
  end

  def starting_balance
    0
  end

  def valid_credit?(_amount)
    @account_valid
  end

  def valid_charge?(_amount)
    @account_valid
  end

  def clean_amount(num)
    num.gsub(/[^0-9]/, '').to_i
  end

end
