RSpec.describe Web::Controllers::Calendars::Destroy, type: :action do
  let(:action) { described_class.new }

  let!(:calendar) { CalendarRepository.new.find(GccgFactory[:calendar].id) }
  let(:params) { { id: id } }

  context 'when sending an existing ID' do
    let(:id) { calendar.id }

    it 'destroys the record' do
      repository = CalendarRepository.new

      expect {
        action.call(params)
      }.to change(repository, :count).by(-1)
    end

    it 'redirects to calendars#index' do
      response = action.call(params)
      expect(response).to redirect_to Web.routes.root_path
    end
  end

  context 'when sending an not existing ID' do
    let(:id) { calendar.id.succ }

    it 'returns 404' do
      response = action.call(params)
      expect(response).to have_http_status :not_found
    end
  end
end
