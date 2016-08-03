require 'sinatra'
require 'slack-ruby-client'
require 'curb'
require 'faraday'

configure do
  Slack.configure do |config|
    config.token = ENV['SLACK_API_TOKEN']
    fail 'Missing ENV[SLACK_API_TOKEN]!' unless config.token
  end
end

post '/p' do
  c = Curl::Easy.new('https://snapark.smartfile.com/api/2/path/data/snapshot.jpg')
  c.http_auth_types = :basic
  c.username = ENV['SMARTFILE_KEY']
  c.password = ENV['SMARTFILE_PASS']
  c.perform

  File.open('snapshot.jpg', 'wb') { |f| f.write(c.body_str) }

  client = Slack::Web::Client.new

  image_file = Faraday::UploadIO.new('snapshot.jpg', 'image/jpeg')

  client.files_upload(
    channels: '#office',
    as_user:  true,
    file:     image_file,
    filename: 'snapshot.jpg'
  )

  return ''
end
