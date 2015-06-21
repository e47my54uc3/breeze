require 'trello'
class User < ActiveRecord::Base
  attr_accessor :status
 

  def find_list
     Trello::List.find(board_id: board.id)
  end
 
  def check_status
    if self.balance <= -200
      @status = 'Open'
    else
      @status = 'Resolved'
    end
  end



end
