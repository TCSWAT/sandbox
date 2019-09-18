class CreateServices < ActiveRecord::Migration[5.2]
  def change
    create_table :services do |t|
      t.string :name, null: false
      t.string :description
      t.string :api_url

      t.bigint :access_id
      t.bigint :secret_key
      t.string :token
      t.string :api_key
      t.string :username
      t.string :passcode

      t.string :auth_type, default: 0, null: false, index: true
      t.integer :status, default: 0, null: false, index:true

      t.timestamps
    end
  end
end
