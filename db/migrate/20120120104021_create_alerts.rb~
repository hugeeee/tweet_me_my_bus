class CreateAlerts < ActiveRecord::Migration
  def self.up
    create_table :alerts do |t|
      t.string :bus_route
      t.string :stop
      t.string :days_of_notification
      t.integer :first_alert
      t.integer :second_alert
      t.integer :third_alert
      t.boolean :active

      t.timestamps
    end
  end

  def self.down
    drop_table :alerts
  end
end
