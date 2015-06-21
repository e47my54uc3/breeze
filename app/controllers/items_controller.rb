require 'date'

class  ItemsController < ApplicationController
  include TrelloHelper

  attr_reader :board

  def initialize
    @trello_client = TrelloHelper.client

    @board = TrelloHelper.board
  end

  def show
    item = Item.where(id: params[:id]).first
    user = User.where(id: item.user_id).first
   
    render :json => { item: item, user: user }
  end

  
  def index
    items = Item.where(params[:user_id])
    render :json => items
  end

 
  def create
    if params[:date]
      item_date = Date.parse(params[:date])
    else
      item_date = Date.parse(Time.now.strftime('%Y-%m-%e'))
    end
 
    item_type = params[:item_type]
    amount = params[:amount]
    user = User.where(id: params[:user_id]).first

    item = Item.create(
      created_at: item_date,
      item_type: item_type,
      amount: amount,
      user_id: user.id,
      updated_at: item_date
    )

    target_card = nil
    list = user.check_status #set the list according to user

    #check for existing card
    board.cards.detect do |card|
      if card.name == user.name
        target_card = card
      end
    end

    #create new card if user is delinquent
    if target_card.nil? && user.delinquent
      @trello_client.create(:card, {
          'name' => user.name,
          'idList' => list
      })
    end

    #update card
    if target_card
      target_card.list_id = list
      target_card.save
    end

    render :json => { item: item, user: user }
  end


end