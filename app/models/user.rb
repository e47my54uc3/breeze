require 'trello'
class User < ActiveRecord::Base
  has_many :items

 

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
    if self.balance <= -200

      self.delinquent = true
      return ENV['Open_list']
    else

      self.delinquent = false
      return ENV['Resolved_list']
    end
  end



end
