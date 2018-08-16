module Web::Controllers::Calendars
  class Destroy
    include Web::Action

    def call(params)
      if calendar = repository.find(params[:id])
        repository.delete(params[:id])

        redirect_to routes.root_path
      else
        halt 404
      end
    end

    private

    def repository
      @repository ||= CalendarRepository.new
    end
  end
end
