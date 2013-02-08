class AddCityToUsers < ActiveRecord::Migration
  def change
    add_column :users, :city_id, :integer
    add_index 'users', ['city_id'], :name => 'index_user_id'
  end
end
