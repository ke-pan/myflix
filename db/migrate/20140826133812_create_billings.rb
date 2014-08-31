class CreateBillings < ActiveRecord::Migration
  def change
    create_table :billings do |t|
      t.date :pay_date
      t.integer :user_id
      t.index :user_id
      t.date :active_until
      t.float :amount
    end
  end
end
