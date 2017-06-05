class CreateRestaurants < ActiveRecord::Migration[5.1]
  def change
    create_table :restaurants do |t|
      t.citext :name, index: true, null: false

      t.timestamps
    end
  end
end
