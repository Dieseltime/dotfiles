#!/usr/bin/env ruby

# Generate projects config
# Example output:
#
# 'fucking_terrible_code':
#   'title': 'fucking_terrible_code'
#   'paths': [
#     '/Users/monkey/projects/fucking_terrible_code'
#   ]

abort("$PROJECTS_DIR is not set") unless ENV['PROJECTS_DIR']
exit(0) unless File.directory? ENV['PROJECTS_DIR']

projects = Dir.entries(ENV['PROJECTS_DIR']).select { |entry|
  File.directory? File.join(ENV['PROJECTS_DIR'], entry) and !(entry =='.' || entry == '..' || entry.start_with?('_'))
}

open(File.join(File.expand_path('~'), '.atom/projects.cson'), 'w') { |f|
  projects.each do |project|

    project_config = <<-EOF
'#{project}':
  'title': '#{project}'
  'paths': [
    '#{File.join(ENV['PROJECTS_DIR'], project)}'
  ]
EOF
    f.puts project_config
  end
}

puts "Generated configs for #{projects.size} projects."
