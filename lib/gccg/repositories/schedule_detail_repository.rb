class ScheduleDetailRepository < Hanami::Repository
  associations do
    belongs_to :schedule
  end
end
