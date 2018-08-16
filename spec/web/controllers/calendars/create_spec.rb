RSpec.describe Web::Controllers::Calendars::Create, type: :action do
  let(:action) { described_class.new }

  let(:calendar_attributes) { GccgFactory.structs[:calendar] }
  let(:title) { calendar_attributes[:title] }
  let(:starts_on) { calendar_attributes[:starts_on] }
  let(:ends_on) { calendar_attributes[:ends_on] }

  let(:params) {
    {
      calendar: {
        title: title,
        starts_on: starts_on,
        ends_on: ends_on
      }
    }
  }

  context 'when sending valid params' do
    it 'creates a record' do
      repository = CalendarRepository.new
      expect { action.call(params) }.to change(repository, :count).by(1)
    end

    it 'redirects to calendars#show' do
      response = action.call(params)

      calendar = CalendarRepository.new.first
      expect(response).to redirect_to Web.routes.calendar_path(calendar.id)
    end
  end

  context 'when title is empty' do
    let(:title) { '' }

    it 'returns 422' do
      response = action.call(params)
      expect(response).to have_http_status :unprocessable_entity
    end
  end

  context 'when title length is 1' do
    let(:title) { 'a' }

    it 'redirects to calendars#show' do
      response = action.call(params)

      calendar = CalendarRepository.new.first
      expect(response).to redirect_to Web.routes.calendar_path(calendar.id)
    end
  end

  context 'when title length is 255' do
    let(:title) { 'a' * 255 }

    it 'redirects to calendars#show' do
      response = action.call(params)

      calendar = CalendarRepository.new.first
      expect(response).to redirect_to Web.routes.calendar_path(calendar.id)
    end
  end

  context 'when title length is greater than 255' do
    let(:title) { 'a' * 256 }

    it 'returns 422' do
      response = action.call(params)
      expect(response).to have_http_status :unprocessable_entity
    end
  end

  context 'when starts_on is not valid date' do
    let(:starts_on) { '201808011' }

    it 'returns 422' do
      response = action.call(params)
      expect(response).to have_http_status :unprocessable_entity
    end
  end

  context 'when ends_on is not valid date' do
    let(:ends_on) { '201808011' }

    it 'returns 422' do
      response = action.call(params)
      expect(response).to have_http_status :unprocessable_entity
    end
  end

  context 'when ends_on preceeds starts_on' do
    let(:starts_on) { '2018-08-02' }
    let(:ends_on) { '2018-08-01' }

    it 'returns 422' do
      response = action.call(params)
      expect(response).to have_http_status :unprocessable_entity
    end
  end
end
