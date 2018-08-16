RSpec.describe Web::Controllers::Calendars::Index, type: :action do
  let(:action) { described_class.new }
  let(:params) { Hash[] }

  context 'when there are no calendars' do
    it 'is successful' do
      response = action.call(params)

      expect(response).to have_http_status :ok
      expect(action.calendars).to be_empty
    end
  end

  context 'when there are calendars' do
    it 'is successful' do
      repository = CalendarRepository.new
      calendar = repository.find(GccgFactory[:calendar].id)
      another_calendar = repository.find(GccgFactory[:calendar].id)

      response = action.call(params)

      expect(response).to have_http_status :ok
      expect(action.calendars).to match_array [calendar, another_calendar]
    end
  end
end
