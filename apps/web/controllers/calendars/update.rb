module Web::Controllers::Calendars
  class Update
    include Web::Action

    expose :calendar

    DATE_REGEX = /\A\d\d\d\d-\d\d-\d\d\z/

    params do
      required(:id).filled(:int?)
      required(:calendar).schema do
        required(:title).filled(:str?, max_size?: 255)
        required(:starts_on).filled(:str?, format?: DATE_REGEX)
        required(:ends_on).filled(:str?, format?: DATE_REGEX)
      end
    end

    def call(params)
      @calendar = repository.find(params[:id])

      if params.valid?
        repository.update(@calendar.id, params[:calendar])

        redirect_to routes.calendar_path(@calendar.id)
      else
        self.status = 422
      end
    end

    private

    def repository
      @repository ||= CalendarRepository.new
    end
  end
end
