# ruby-fann-examples
Simple exercises to help me learn to use FANN

In all of these examples, we use `rake` to create, fetch, preprocess, etc. the datasets.

## sorter

Trains a neural network to recognize if three numbers are sorted a < b < c.

    cd sorter
    bundle exec rake 
    bundle exec ./sorter.rb

## mpg

Inspired by an example in https://github.com/gbuesing/neural-net-ruby

The data comes from https://archive.ics.uci.edu/ml/datasets/Auto+MPG 

    cd mpg
    bundle exec rake
    bundle exec ./mpg.rb

## ocr

Data set from https://archive.ics.uci.edu/ml/datasets/Optical+Recognition+of+Handwritten+Digits

    cd ocr
    bundle exec rake
    bundle exec ./ocr-test.rb
    bundle exec ./ocr-train.rb


