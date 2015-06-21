require 'trello'
require 'date'

class User < ActiveRecord::Base
  has_many :items
 
  def current_balance
   
    last_item = self.items.last

    if last_item.item_type == 'fee'
      self.balance -= last_item.amount
    else
      self.balance += last_item.amount
    end

    self.save
  end


  def add_delinquency_fee
    self.balance += (-5 * self.delinquency_lapse)
    self.save
  end
 
  def check_status
    current_balance

    if self.balance <= -200
      last_pmt_date = self.updated_at.strftime('%Y-%m-%e')
      last_item_date = Item.where(user_id: self.id).last.created_at.strftime('%Y-%m-%e')

      #adjust delinquency days : elapsed item notice time added with current days outstanding
      days = Date.parse(last_item_date).mjd - Date.parse(last_pmt_date).mjd + self.delinquency_lapse
     
      self.update(delinquent: true)
      self.update(delinquency_lapse: days)
    else
      self.update(delinquent: false)
      self.update(delinquency_lapse: 0)
    end

    add_delinquency_fee

    if self.delinquent
      return ENV['Open']
    else
      return ENV['Resolved']
    end
  end


end
