class AddParamsForMatch < ActiveRecord::Migration[6.1]
  def change
    add_column :matches, :owner, :string, null: false
    add_column :matches, :participant, :string
  end
end
