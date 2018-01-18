# frozen_string_literal: true
require_relative './payment_instrument'
require './modules/luhn_10_verifier'

class CreditCard < PaymentInstrument

  include LuhnVerifier

  private

  def valid_account_number?(num)
    valid_luhn_number?(num)
  end

  def starting_balance
    @account_valid ? 0 : 'error'
  end

  def valid_credit?(_amount)
    @account_valid
  end

  def valid_charge?(amount)
    @account_valid && amount_under_limit?(amount)
  end

  def amount_under_limit?(amount)
    @balance + amount <= @limit
  end

end
