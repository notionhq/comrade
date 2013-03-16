class AddStuffToUsers < ActiveRecord::Migration
  def change
    add_column :users, :avatar, :string
    add_column :users, :name, :string
    add_column :users, :github, :string
    add_column :users, :login, :string
  end
end
