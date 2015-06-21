require 'trello'
module TrelloHelper

  Trello.configure do |config|
    config.developer_public_key = ENV['developer_key'] # The "key" from step 1
    config.member_token = ENV['member_secret_token'] # The token from step 3.
  end

  def self.new_client
    Trello::Client.new(
      :consumer_key => ENV['developer_key'],
      :consumer_secret => ENV['member_secret_token']
      )
  end

end
