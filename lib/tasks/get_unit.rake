namespace :db do
  desc "Get unit"
  task :get_unit => :environment do
     BasicFood.select("unit as unit, count(*)").group("unit").each do |unit|
       Unit.create!(name: unit)
     end
  end
end
