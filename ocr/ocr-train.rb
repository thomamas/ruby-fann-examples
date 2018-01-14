#!/usr/local/bin/ruby

require 'ruby-fann'
require 'json'

training = JSON.parse File.read 'optdigits-tra.json'
num_inputs = training['inputs'].first.size
num_outputs = training['outputs'].first.size
neuron_count = ((num_inputs + num_outputs)**0.5).round + 1

train = RubyFann::TrainData.new(
  inputs: training['inputs'],
  desired_outputs: training['outputs']
)

fann = RubyFann::Standard.new(
  num_inputs: num_inputs,
  hidden_neurons: [neuron_count],
  num_outputs: num_outputs
)

puts 'Info...'
puts "Neuron count #{neuron_count}"

puts
puts 'Training...'
fann.train_on_data(train, 10_000, 100, 0.01)

puts
puts 'Saving...'
fann.save('fann-data')
