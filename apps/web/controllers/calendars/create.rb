require_relative './params_validation'

module Web::Controllers::Calendars
  class Create
    include Web::Action
    include ParamsValidation

    def call(params)
      if params.valid? && starts_on_preceeds_ends_on?(params)
        calendar = CalendarRepository.new.create(params[:calendar])

        redirect_to routes.calendar_path(calendar.id)
      else
        self.status = 422
      end
    end
  end
end
