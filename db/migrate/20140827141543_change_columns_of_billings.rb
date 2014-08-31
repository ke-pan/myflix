class ChangeColumnsOfBillings < ActiveRecord::Migration
  def change
    change_column :billings, :pay_date, :datetime
    change_column :billings, :active_until, :datetime
    change_column :users, :active_until, :datetime
  end
end
