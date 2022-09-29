class AddStatusToTransactions < ActiveRecord::Migration[6.0]
  def change
    add_column :transactions, :status, :integer, default: 0
  end
end
