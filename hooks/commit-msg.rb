#!/usr/bin/env ruby
require 'net/http'
require 'json'

message_file = ARGV[0]
message      = File.read(message_file)
$regex       = /#(\d+)/

def get_issues
  uri = URI('https://api.github.com/repos/bernardog/hypermath_api/issues')
  JSON.parse(Net::HTTP.get(uri))
end

if $regex.match message

  number = message[/#(\d+)/]

  get_issues.each do |issue|
    exit 0 if number.include? issue['number'].to_s
  end

  puts "[POLICY] BAD FORMATED MESSAGE – ISSUE NUMBER DOES NOT EXIST"
  exit 1

else
  puts "[POLICY] BAD FORMATTED MESSAGE – NEEDS TO REFERENCE AN ISSUE"
  exit 1
end