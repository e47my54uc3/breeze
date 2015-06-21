class AddDelinquencyLapseToUser < ActiveRecord::Migration
  def change
    add_column :users, :delinquency_lapse, :integer, default: 0
  end
end
