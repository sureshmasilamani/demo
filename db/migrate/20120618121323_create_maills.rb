class CreateMaills < ActiveRecord::Migration
  def self.up
    create_table :maills do |t|
      t.string :name
      t.string :user_id 
      t.timestamps
    end
  end

  def self.down
    drop_table :maills
  end
end
