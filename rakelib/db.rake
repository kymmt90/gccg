namespace :db do
  desc 'Insert seed data to database'
  task seed: :environment do
    repository = GarbageRepository.new
    %w(combustible non_combustible recyclable).each do |segregation|
      unless repository.garbages.where(segregation: segregation).exist?
        repository.create(segregation: segregation)
      end
    end
  end
end
