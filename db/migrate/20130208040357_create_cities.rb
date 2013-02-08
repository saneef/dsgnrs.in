class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.string :name
      t.string :slug

      t.timestamps
    end

    add_index :cities, :slug, unique: true
  end
end
