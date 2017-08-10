class CreateAdUnits < ActiveRecord::Migration[5.1]
  def change
    create_table :ad_units do |t|
      t.string :name
      t.string :url
      t.integer :status, default: 0
      t.string :error_message, default: " "
      t.references :account, foreign_key: true

      t.timestamps
    end
  end
end
