# frozen_string_literal: true
require 'minitest/autorun'
require './lib/processor'

describe Processor do
  describe 'Processor takes STDIN' do
    before do
      @cc_processor = Processor.new
      test_input = ['Add Joe 4563331477044622 $100',
                    'Add Joe2 4563331477044622 $200',
                    'Add Jill 4120817716907484 $3000',
                    'Add Jenny 3453453453453345 %400',
                    'Charge Jill $50',
                    'Charge Jill $5000']
      ARGF.stub :readlines, test_input do
        @cc_processor.stub :generate_summary, nil do
          @cc_processor.run_processor
        end
      end
    end

    it 'Add Account successful for Luhn 10 valid Credit Cards' do
      @cc_processor.instruments.first.name.must_equal('Joe')
    end

    it 'New Account balance zero' do
      @cc_processor.instruments.first.balance.must_equal(0)
    end

    it 'Adding duplicate account_number does not overwrite and is ignored' do
      @cc_processor.instruments.first.limit.must_equal(100)
    end

    it 'Account accrues balance' do
      instrument = @cc_processor.instruments.find { |i| i.name == 'Jill' }
      instrument.balance.must_equal(50)
    end

    it 'Account respects limit' do
      instrument = @cc_processor.instruments.find { |i| i.name == 'Jill' }
      instrument.balance.must_equal(50)
    end

    it 'Add ignored for non-valid Luhn 10 Account Numbers' do
      @cc_processor.instruments.last.balance.must_equal('error')
    end
  end
end
