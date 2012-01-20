class AddUserIdToAlerts < ActiveRecord::Migration
  def self.up
    add_column :alerts, :user_id, :integer
  end

  def self.down
    remove_column :alerts, :user_id
  end
end
