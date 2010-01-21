class AddCreditToCourse < ActiveRecord::Migration
  def self.up
    add_column :courses, :credit_hours, :integer
  end

  def self.down
    remove_column :courses, :credit_hours
  end
end
