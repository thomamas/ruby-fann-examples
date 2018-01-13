#!/usr/local/bin/ruby

require 'ruby-fann'
require 'json'

training = JSON.parse File.read 'data_training.json'
testing = JSON.parse File.read 'data_testing.json'

num_inputs = training['inputs'].first.size
num_outputs = training['outputs'].first.size
neuron_count = ((num_inputs + num_outputs)**0.5).round + 1

train = RubyFann::TrainData.new(
  inputs: testing['inputs'],
  desired_outputs: testing['outputs']
)

fann = RubyFann::Standard.new(
  num_inputs: num_inputs,
  hidden_neurons: [neuron_count],
  num_outputs: num_outputs
)

puts 'Training...'
fann.train_on_data(train, 10_000, 100, 0.001)

puts
puts 'Testing...'

misses = 0
testing['inputs'].each.with_index do |input, i|
  actual_output = fann.run(input)[0]
  rounded_output = actual_output.round
  desired_output = testing['outputs'][i][0]
  unless rounded_output == desired_output
    misses += 1
    puts "#{input} : got #{actual_output} wanted #{desired_output}"
  end
end

puts "#{misses} misses in #{testing['inputs'].length} trials"
