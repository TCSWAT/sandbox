class CreateSubscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :subscriptions do |t|
      t.references :client, index: true
      t.references :service, index: true

      t.timestamps
    end
  end
end
