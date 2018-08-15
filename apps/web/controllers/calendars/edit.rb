module Web::Controllers::Calendars
  class Edit
    include Web::Action

    expose :calendar

    def call(params)
      @calendar = CalendarRepository.new.find(params[:id])
    end
  end
end
