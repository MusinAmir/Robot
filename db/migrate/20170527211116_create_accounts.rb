class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|
      t.string :login
      t.string :password	
      t.integer :status, default: 0
      t.string :error_message, default: " "
      
      t.timestamps
    end
  end
end
