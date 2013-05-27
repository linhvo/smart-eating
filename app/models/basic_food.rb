class BasicFood < ActiveRecord::Base
  attr_accessible :name, :fatsecret_id, :fatsecret_url, :calories, :fat, :carb, :protein, :unit, :amount, :brand_name, :group_id

end
