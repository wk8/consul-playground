#!/usr/bin/env ruby

## Generates docker-compose.yml

require 'erb'
require 'optparse'
require 'ostruct'

def parse_opts!
  options = {
    'servers' => 3,
    'clients' => 2,
  }
  
  OptionParser.new do |opts|
    opts.banner = 'Consul playground'

    options.each do |opt, default|
      [opt[0], opt].each do |env_var|
        if ENV[env_var.upcase]
          options[opt] = Integer(ENV[env_var.upcase])
        end
      end

      opts.on("-#{opt[0]} N", "--#{opt} N", Integer, "How many #{opt} (defaults to #{default})?") do |count|
        options[opt] = count
      end
    end

    opts.on('-h', '--help', 'Prints this help') do
      puts opts
      exit 1
    end
  end.parse!
  
  options
end

def main
  template = ERB.new(File.read('docker-compose.yml.erb'))
  result = template.result(OpenStruct.new(parse_opts!).instance_eval { binding })
  File.write('docker-compose.yml', result)
end

main
