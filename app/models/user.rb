require 'trello'
class User < ActiveRecord::Base
  has_many :items
  attr_accessor :which_list

  def initialize
    @which_list = self.delinquent
  end

 
  def total_balance
    total = self.balance
    
    accumulation = 0

    self.items.each do |item|
      if item.item_type == 'fee'
        accumulation -= (item.amount.abs)
      else
        accumulation += (item.amount.abs)
      end
    end

    self.balance += accumulation
    self.save
  end
 
  def check_status
    total_balance

    if self.balance <= -200
      self.update(delinquent: true)
    else
      self.update(delinquent: false)
    end

    #find the user on the board
    #delete the user
    #add to proper_board
    # if self.created_at != self.updated_at

    # end
  end



end
