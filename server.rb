require 'sinatra'

configure do
  # SmartFile
  SMARTFILE_CONFIG['key'] = ENV['SMARTFILE_KEY']
  SMARTFILE_CONFIG['pass'] = ENV['SMARTFILE_PASS']
end

get '/' do
  redirect 'https://snapark.e1.loginrocket.com/'
end


get '/s' do
  # send_file ...
end
