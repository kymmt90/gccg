class ScheduleRepository < Hanami::Repository
  associations do
    belongs_to :calendar
    belongs_to :garbage
  end
end
