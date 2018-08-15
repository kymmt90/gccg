module Web::Controllers::Calendars
  class Create
    include Web::Action

    DATE_REGEX = /\A\d\d\d\d-\d\d-\d\d\z/

    params do
      required(:calendar).schema do
        required(:title).filled(:str?, max_size?: 255)
        required(:starts_on).filled(:str?, format?: DATE_REGEX)
        required(:ends_on).filled(:str?, format?: DATE_REGEX)
      end
    end

    def call(params)
      if params.valid?
        calendar = CalendarRepository.new.create(params[:calendar])

        redirect_to routes.calendar_path(calendar.id)
      else
        self.status = 422
      end
    end
  end
end
