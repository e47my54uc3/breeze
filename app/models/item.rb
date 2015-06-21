class Item < ActiveRecord::Base
  belongs_to :user

  validates :item_type, :inclusion => { :in => %w(fee payment) }

  def choose_board


  end
  
end
