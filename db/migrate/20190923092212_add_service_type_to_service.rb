class AddServiceTypeToService < ActiveRecord::Migration[5.2]
  def change
    add_column :services, :service_type, :integer, default: 0, null: false, index: true
  end
end
