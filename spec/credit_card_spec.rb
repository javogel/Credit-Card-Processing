# frozen_string_literal: true
require 'minitest/autorun'
require './lib/credit_card'

describe CreditCard do
  describe 'Invalid Accounts' do
    before do
      @card = CreditCard.new(name: 'Name', account_number: '1234567', limit: '$1000')
    end

    it 'If account_number Luhn 10 invalid, balance is zero' do
      @card.balance.must_equal('error')
    end

    it 'Charge to invalid account is ignored' do
      @card.charge('55')
      @card.balance.must_equal('error')
    end

    it 'Credit to invalid account is ignored' do
      @card.credit('55')
      @card.balance.must_equal('error')
    end
  end

  describe 'Valid Accounts' do
    before do
      @card = CreditCard.new(name: 'Name', account_number: '4059360235622081', limit: '$1000')
    end

    it 'Initial balance is zero' do
      @card.balance.must_equal(0)
    end

    it 'Valid charge is applied' do
      @card.charge('55')
      @card.balance.must_equal(55)
    end

    it 'Credit to valid account is applied' do
      @card.credit('5')
      @card.balance.must_equal(-5)
    end

    it 'Charge over limit is ignored' do
      @card.charge('5000')
      @card.balance.must_equal(0)
    end
  end
end
