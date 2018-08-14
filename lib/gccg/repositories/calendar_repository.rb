class CalendarRepository < Hanami::Repository
  associations do
    has_many :schedules
  end
end
