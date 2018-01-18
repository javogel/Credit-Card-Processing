# frozen_string_literal: true

require_relative './credit_card'

class Processor
  attr_reader :instruments

  def initialize(args = { instrument_type: nil })
    @transactions = []
    @instruments = []
    @instrument_type = args[:instrument_type] || default_instrument_type
  end

  def run_processor
    read_inputs
    process_transactions
    generate_summary
  end

  private

  def read_inputs
    ARGF.readlines.each do |line|
      @transactions << line.split(' ')
    end
  end

  def process_transactions
    @transactions.each { |t| apply_transaction(t) }
  end

  def apply_transaction(t)
    case t[0].downcase
    when 'add'
      add(name: t[1], account_number: t[2], limit: t[3])
    when 'charge'
      charge(name: t[1], amount: t[2])
    when 'credit'
      credit(name: t[1], amount: t[2])
    end
  end

  def add(args)
    instrument = @instrument_type.new(args)
    @instruments << instrument if instrument_is_new?(instrument)
  end

  def charge(args)
    instrument = find_instrument(args[:name])
    instrument.charge(args[:amount]) unless instrument.nil?
  end

  def credit(args)
    instrument = find_instrument(args[:name])
    instrument.credit(args[:amount]) unless instrument.nil?
  end

  def find_instrument(name)
    @instruments.find { |c| c.name == name }
  end

  def instrument_is_new?(instrument)
    @instruments.all? { |c| c.account_number != instrument.account_number }
  end

  def generate_summary
    @instruments.sort_by(&:name).each do |c|
      puts c.name + ': ' + c.printable_balance
    end
  end

  def default_instrument_type
    CreditCard
  end
end
