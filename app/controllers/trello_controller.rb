class  TrelloController < ApplicationController
  include TrelloHelper
  attr_accessor :trello

  def initialize
    @trello = TrelloHelper.new_client
  end

  

end