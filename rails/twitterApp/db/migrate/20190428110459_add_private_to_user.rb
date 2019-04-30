class AddPrivateToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :private, :boolean
  end
end
