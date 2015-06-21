class  TrelloController < ApplicationController
  include TrelloHelper

  attr_reader :board

  def initialize
    @board = Trello::Board.all.find { |board| board.id == ENV['balance_tracker_board'] }
  end
  

  def show
    puts board
  end




  

end