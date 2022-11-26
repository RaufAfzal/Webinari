class RenameContactNumnberToContactNumberInCustomers < ActiveRecord::Migration[7.0]
  def change
    rename_column :customers, :contact_numnber, :contact_number
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
