class CreateFoodGroups < ActiveRecord::Migration
  def up
    create_table :food_groups do |t|
      t.string :name
      t.timestamps
    end
  end

  def down
    drop_table :food_groups
  end
end
