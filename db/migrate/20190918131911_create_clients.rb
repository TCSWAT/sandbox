class CreateClients < ActiveRecord::Migration[5.2]
  def change
    create_table :clients do |t|
      t.string :name, null: false
      t.integer :user_id
      t.string :api_key

      t.integer :status, default: 0, null: false, index:true

      t.timestamps
    end
  end
end
