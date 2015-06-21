class  ItemsController < ApplicationController
  include TrelloHelper

  attr_reader :board

  def initialize
    @board = Trello::Board.all.find { |board| board.id == ENV['balance_tracker_board'] }
  end
  
  def index
    items = Item.where(params[:user_id])
    render :json => items
  end

  # def show
  #   # @user = User.first
  #   u = User.find(params[:user_id])

  #   # list = u.check_status
  #   # render :json => list
  #   render :json => u
  # end


  def create
    user = User.find(params[:user_id])

    render :json => board
  end






  

end