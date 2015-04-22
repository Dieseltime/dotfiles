#!/usr/bin/env ruby

# I copied this from somewhere -- not very effecient
puts `/usr/local/bin/rbenv install --list`.split("\n").map{ |item| item.strip }.select{ |item| item[/^\d*\.\d*\.\d*/]}.reject{ |item| (item.include? '-') && !(item =~ /-p\d*$/) }.last
