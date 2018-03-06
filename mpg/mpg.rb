#!/usr/bin/env ruby

require 'csv'
require 'json'
require 'ruby-fann'

#
# --- test
#

def test(nn, x, y)
  total_error = 0
  trials = 0

  x.each.with_index do |input, i|
    output = nn.run(input)[0]
    scaled_error = 60 * (output - y[i][0]).abs
    trials += 1
    total_error += scaled_error
  end

  puts "avg error #{total_error / trials} in #{trials} trials"
end

#
# -- main
#

rows = CSV.read 'auto-mpg.data', col_sep: ' '
rows.shuffle!

x_data = []
y_data = []

rows.each do |row|
  mpg = row[0].to_f / 60
  cylinders = row[1].to_f / 12
  displacement = row[2].to_f / 1000
  horsepower = row[3].to_f / 1000
  weight = row[4].to_f / 5000
  x_data << [cylinders, displacement, horsepower, weight]
  y_data << [mpg]
end

test_size = 100
train_size = rows.length - test_size

x_train = x_data.slice(0, train_size)
y_train = y_data.slice(0, train_size)
x_test = x_data.slice(train_size, test_size)
y_test = y_data.slice(train_size, test_size)

train = RubyFann::TrainData.new(
  inputs: x_train,
  desired_outputs: y_train
)

fann = RubyFann::Standard.new(
  num_inputs: 4,
  hidden_neurons: [3],
  num_outputs: 1
)

puts 'before training:'
test(fann, x_test, y_test)

puts
puts 'training...'

fann.train_on_data(train, 10_000, 100, 0.004)

puts
puts 'post training'
test(fann, x_test, y_test)
