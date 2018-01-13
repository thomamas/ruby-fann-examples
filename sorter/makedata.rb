#!/usr/local/bin/ruby

require 'json'

data_size = (ARGV[0] || 1000).to_i

inputs = (1..data_size).map do
  [rand, rand, rand]
end

outputs = inputs.map do |row|
  row[0] < row[1] && row[1] < row[2] ? [1] : [0]
end

puts JSON.pretty_generate(inputs: inputs, outputs: outputs)
