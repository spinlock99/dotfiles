#!/usr/bin/env ruby
require 'json'
require 'open3'
require 'getoptlong'
require 'io/console'

host = 'localhost:3000'
email_address = 'student@amaranta.edu'
password = 'fishtank!'

opts = GetoptLong.new(['--environment', '-e', GetoptLong::OPTIONAL_ARGUMENT])

opts.each do |opt, arg|
  case opt
  when '--environment'
    case arg
    when 'mobile'
      host = 'http://192.168.1.193:3000'
    when 'staging'
      host = 'https://staging.joinhandshake.com'
      email_address = 'andrew@amaranta.edu'
      password = 'fishtank123!'
    when 'demo'
      puts 'demo is not supported yet'
      exit
    when 'production'
      host = 'https://app.joinhandshake.com'
      email_address = 'dixon99@alumni.middlebury.edu'
      print 'password: '
      password = STDIN.noecho(&:gets).chomp
    end
  end
end

# First, we curl the sessions endpoint to get a javascript web token:
header = 'Content-Type: application/json; charset=utf-8'
session_data = { password: password, email_address: email_address }
# capture the auth token
puts Open3.capture2(%Q(curl #{host}/mobile/v1/sessions --data '#{session_data.to_json}' --header '#{header}' | jq -r '.data.attributes["auth-token"]')).first
