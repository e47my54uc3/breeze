class  ItemsController < ApplicationController
  include TrelloHelper

  attr_reader :board

  def initialize
    @trello_client = TrelloHelper.client

    @board = TrelloHelper.board
    binding.pry

  end

   # def show
  #   # @user = User.first
  #   u = User.find(params[:user_id])

  #   # list = u.check_status
  #   # render :json => list
  #   render :json => u
  # end

  
  def index
    items = Item.where(params[:user_id])
    render :json => items
  end

 
  def create

    item_type = params[:item_type]
    amount = params[:amount]
    user = User.where(id: params[:user_id]).first

    Item.create(
      item_type: item_type,
      amount: amount,
      user_id: user.id
    )

    user.check_status

    # p binding.byebug

    if user.delinquent
      list_id = ENV['Open']
    else
      list_id = ENV['Resolved']
    end

    

    card = @trello_client.create(:card, {
      'name' => user.name,
      'idList' => list_id,
    })

  end


  def show
    item_type = params[:item_type]
    amount = params[:amount]

    item = Item.where(id: params[:id]).first
    user = User.where(id: item.user_id).first

    user.check_status
    user.delinquent ? list_id = ENV['Open_list'] : list_id = ENV['Resolved_list']



    render :json => { item: item, user: user, list_id: list_id}

    # user = User.where(id: item.user_id)


    # user.check_status

    #



    # render :json => list_id
  end






  

end