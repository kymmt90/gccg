RSpec.describe Web::Controllers::Calendars::Show, type: :action do
  let(:action) { described_class.new }
  let(:params) { { id: id } }

  context 'when a calendar is found' do
    let(:calendar) { CalendarRepository.new.find(GccgFactory[:calendar].id) }
    let(:id) { calendar.id }

    it 'is successful' do
      response = action.call(params)

      expect(response).to have_http_status :ok
      expect(action.calendar).to eq calendar
    end
  end

  context 'when a calendar is not found' do
    let(:id) { 1 }

    before { CalendarRepository.new.clear }

    it 'is successful' do
      response = action.call(params)

      expect(response).to have_http_status :not_found
    end
  end
end
