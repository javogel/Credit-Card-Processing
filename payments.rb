#!/usr/local/bin/ruby -w
require './lib/processor'
require './lib/credit_card'

app = Processor.new(instrument_type: CreditCard)
app.run_processor
