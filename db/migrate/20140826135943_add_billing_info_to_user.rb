class AddBillingInfoToUser < ActiveRecord::Migration
  def change
    add_column :users, :active_until, :date
    add_column :users, :stripe_user_id, :string
  end
end
