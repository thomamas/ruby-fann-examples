#!/usr/local/bin/ruby

require 'ruby-fann'
require 'json'

testing = JSON.parse File.read 'optdigits-cv.json'

fann = RubyFann::Standard.new(filename: 'fann-data')

puts
puts 'Testing...'

lines = 0
errors = 0

testing['inputs'].each.with_index do |input, i|
  actual_output = fann.run(input)
  m = actual_output.max
  mn = actual_output.find_index { |x| x == m }

  desired_output = testing['outputs'][i]
  d = desired_output.max
  dn = desired_output.find_index { |x| x == d }

  # puts "got << #{mn} >> from  #{actual_output} wanted #{desired_output}"
  puts "got #{mn} wanted #{dn}" unless mn == dn
  errors += 1 unless mn == dn
  lines += 1
end

puts "#{errors} in #{lines} trials = #{errors.to_f / lines}"
