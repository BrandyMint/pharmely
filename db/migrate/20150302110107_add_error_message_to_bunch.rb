class AddErrorMessageToBunch < ActiveRecord::Migration
  def change
    add_column :bunches, :error_message, :text
  end
end
