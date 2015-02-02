class AddLoginAndPasswordToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :login, :string
    add_column :companies, :password, :string
  end
end
