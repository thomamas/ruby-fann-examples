#!/usr/local/bin/ruby

require 'json'

lines = ARGF.readlines
lines.shift 21 # eat preamble

inputs = []
outputs = []

until lines.empty?
  x = lines.shift(32).join.split('').map(&:to_i)
  inputs << x

  /(\d)/ =~ lines.shift
  y = Regexp.last_match[1].to_f
  o = [
    y == 0 ? 1 : 0,
    y == 1 ? 1 : 0,
    y == 2 ? 1 : 0,
    y == 3 ? 1 : 0,
    y == 4 ? 1 : 0,
    y == 5 ? 1 : 0,
    y == 6 ? 1 : 0,
    y == 7 ? 1 : 0,
    y == 8 ? 1 : 0,
    y == 9 ? 1 : 0
  ]

  outputs << o
end

puts JSON.pretty_generate(inputs: inputs, outputs: outputs)
