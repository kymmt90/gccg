module Web::Controllers::Calendars
  class Index
    include Web::Action

    expose :calendars

    def call(params)
      @calendars = CalendarRepository.new.all
    end
  end
end
