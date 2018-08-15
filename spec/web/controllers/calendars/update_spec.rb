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

    it 'returns 302' do
      response = action.call(params)
      expect(response[0]).to eq 302
    end
  end

  context 'when title is empty' do
    let(:title) { '' }

    it 'returns 422' do
      response = action.call(params)
      expect(response[0]).to eq 422
    end
  end

  context 'when title length is 1' do
    let(:title) { 'a' }

    it 'returns 302' do
      response = action.call(params)
      expect(response[0]).to eq 302
    end
  end

  context 'when title length is 255' do
    let(:title) { 'a' * 255 }

    it 'returns 302' do
      response = action.call(params)
      expect(response[0]).to eq 302
    end
  end

  context 'when title length is greater than 255' do
    let(:title) { 'a' * 256 }

    it 'returns 422' do
      response = action.call(params)
      expect(response[0]).to eq 422
    end
  end

  context 'when starts_on is not match the specified date format' do
    let(:starts_on) { '20180801' }

    it 'returns 422' do
      response = action.call(params)
      expect(response[0]).to eq 422
    end
  end

  context 'when ends_on is not match the specified date format' do
    let(:ends_on) { '20180801' }

    it 'returns 422' do
      response = action.call(params)
      expect(response[0]).to eq 422
    end
  end
end
