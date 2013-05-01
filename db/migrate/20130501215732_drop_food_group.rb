class DropFoodGroup < ActiveRecord::Migration
  def up
    drop_table :food_groups
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
