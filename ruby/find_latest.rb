#!/usr/bin/env ruby

# I copied this from somewhere -- not very effecient

rbenv = `which rbenv`.strip
puts `#{rbenv} install --list`.split("\n").map{ |item| item.strip }.select{ |item| item[/^\d*\.\d*\.\d*/]}.reject{ |item| (item.include? '-') && !(item =~ /-p\d*$/) }.last
