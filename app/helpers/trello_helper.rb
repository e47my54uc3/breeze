require 'trello'
module TrelloHelper

  Trello.configure do |config|
    config.developer_public_key = ENV['developer_public_key'] 
    config.member_token = ENV['authorize_write_token']
  end

  

  

end
