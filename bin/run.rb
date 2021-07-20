#!/usr/bin/env ruby
require_relative "../lib/tracker.rb"

input = ARGV.first 
output = ARGV.last
if ARGV.length == 2 
  run(input, output)
else 
  puts "please enter an excel sheet to parse and your desired output file name"
end 


def hi 
  puts "enter ur name"
  answer = gets.chomp
  puts "hello #{answer}"
end 

