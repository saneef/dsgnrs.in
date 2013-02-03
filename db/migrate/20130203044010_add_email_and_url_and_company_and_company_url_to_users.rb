class AddEmailAndUrlAndCompanyAndCompanyUrlToUsers < ActiveRecord::Migration
  def change
    add_column :users, :email, :string
    add_column :users, :url, :string
    add_column :users, :company, :string
    add_column :users, :company_url, :string
  end
end
