class CalendarRepository < Hanami::Repository
  associations do
    has_many :schedules
  end

  def count
    calendars.count
  end
end
