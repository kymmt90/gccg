require_relative './params_validation'

module Web::Controllers::Calendars
  class Update
    include Web::Action
    include ParamsValidation

    expose :calendar

    def call(params)
      @calendar = repository.find(params[:id])

      if params.valid? && starts_on_preceeds_ends_on?(params)
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
