class CreateArticles < ActiveRecord::Migration
  def self.up
    create_table :articles do |t|
      t.column :name, :string
      t.column :department_id, :integer
      t.timestamps
    end
  end

  def self.down
    drop_table :articles
  end
end
