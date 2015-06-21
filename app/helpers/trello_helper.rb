require 'trello'
module TrelloHelper

  Trello.configure do |config|
    config.developer_public_key = ENV['developer_public_key'] 
    config.member_token = ENV['authorize_write_token']
  end


  def self.client
    Trello::Client.new(
      developer_public_key: ENV['developer_public_key'],
      member_token: ENV['authorize_write_token'],
    )
  end

  def self.board
    Trello::Board.all.detect { |board| board.id == ENV['balance_board'] }
  end

  

end
