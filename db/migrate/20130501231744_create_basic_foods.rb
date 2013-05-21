class CreateBasicFoods < ActiveRecord::Migration
  def up
    create_table :basic_foods do |t|
      t.string :name
      t.string :fatsecret_url
      t.integer :fatsecret_id
      t.float :calories
      t.float :fat
      t.float :protein
      t.float :carb
      t.float :amount
      t.string :unit
      t.string :brand_name
      t.integer :group_id

      t.timestamps
    end
  end

  def down
    drop_table :basic_foods
  end
end
