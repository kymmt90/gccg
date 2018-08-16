RSpec.describe Web::Controllers::Calendars::Update, type: :action do
  let(:action) { described_class.new }

  let!(:calendar) { CalendarRepository.new.find(GccgFactory[:calendar].id) }
  let(:title) { "[UPDATE] #{calendar.title}" }
  let(:starts_on) { (calendar.starts_on >> 1).iso8601 }
  let(:ends_on) { (calendar.ends_on >> 1).iso8601 }

  let(:params) {
    {
      id: calendar.id,
      calendar: {
        title: title,
        starts_on: starts_on,
        ends_on: ends_on
      }
    }
  }

  context 'when sending valid params' do
    it 'updates a record' do
      action.call(params)

      updated = CalendarRepository.new.find(calendar.id)
      expect(updated.title).to eq "[UPDATE] #{calendar.title}"
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

  context 'when starts_on is not match the specified date format' do
    let(:starts_on) { '20180801' }

    it 'returns 422' do
      response = action.call(params)
      expect(response).to have_http_status :unprocessable_entity
    end
  end

  context 'when ends_on is not match the specified date format' do
    let(:ends_on) { '20180801' }

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
