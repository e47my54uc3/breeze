require 'trello'
class User < ActiveRecord::Base
  has_many :items

  attr_accessor :which_list

 

  def find_list
     Trello::List.find(board_id: board.id)
  end

  def total_balance
    self.balance = 0

    self.items.each do |item|
      if item.item_type == 'fee'
        self.balance -= item.amount
      else
        self.balance += item.amount
      end
    end
    self.save
  end
 
  def check_status
    total_balance

    if self.balance <= -200
      self.update(delinquent: true)
    else
      self.update(delinquent: false)
    end
  end



end
