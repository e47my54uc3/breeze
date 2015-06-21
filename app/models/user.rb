require 'trello'
require 'date'

class User < ActiveRecord::Base
  has_many :items
 
  def total_balance
    #check delinquency days outstanding
    if self.delinquent
      accumulation = (-5 * self.delinquency_lapse)
    else
      accumulation = 0
    end

    #total fees and payments
    self.items.each do |item|
      if item.item_type == 'fee'
        accumulation -= (item.amount)
      else
        accumulation += (item.amount)
      end
    end

    self.balance = accumulation
    self.save
  end
 
  def check_status
    total_balance
    
    if self.balance <= -200
      last_pmt_date = self.updated_at.strftime('%Y-%m-%e')
      last_item_date = Item.where(user_id: self.id).last.created_at.strftime('%Y-%m-%e')

      #adjust delinquency days : elapsed item notice time added with days outstanding
      days = Date.parse(last_item_date).mjd - Date.parse(last_pmt_date).mjd + self.delinquency_lapse
     
      self.update(delinquent: true)
      self.update(delinquency_lapse: days)
    else
      self.update(delinquent: false)
      self.update(delinquency_lapse: 0)
    end

    # total_balance

    if self.delinquent
      return ENV['Open']
    else
      return ENV['Resolved']
    end
  end


end
