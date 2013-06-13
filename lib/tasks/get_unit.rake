namespace :db do
  desc "Get unit"
  task :get_unit => :environment do
    Unit.delete_all
     BasicFood.select("unit as unit, count(*)").group("unit").each do |u|
       Unit.create!(name: u.unit)
     end
  end
end
