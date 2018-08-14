class GarbageRepository < Hanami::Repository
  associations do
    has_many :schedules
  end

  def combustible
    garbages.where(segregation: 'combustible').one
  end

  def non_combustible
    garbages.where(segregation: 'non_combustible').one
  end

  def recyclable
    garbages.where(segregation: 'recyclable').one
  end
end
