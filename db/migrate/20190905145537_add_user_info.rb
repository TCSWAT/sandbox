class AddUserInfo < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :first_name, :string, null: false
    add_column :users, :last_name, :string, null: false
    add_column :users, :status, :integer, null: false, default: 0, index: true
  end
end
