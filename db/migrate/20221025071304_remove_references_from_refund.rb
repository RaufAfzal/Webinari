class RemoveReferencesFromRefund < ActiveRecord::Migration[7.0]
  def change
    remove_column :refunds, :references, :string
  end
end
