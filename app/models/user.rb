require 'trello'
class User < ActiveRecord::Base
  has_many :items
  attr_accessor :which_list


 
  def total_balance
    accumulation = self.balance

    self.items.each do |item|
      if item.item_type == 'fee'
        accumulation -= (item.amount)
      else
        accumulation += (item.amount)
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

  end



end
