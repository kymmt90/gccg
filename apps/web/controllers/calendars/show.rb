module Web::Controllers::Calendars
  class Show
    include Web::Action

    expose :calendar

    def call(params)
      if calendar = CalendarRepository.new.find(params[:id])
        @calendar = calendar
      else
        halt 404
      end
    end
  end
end
