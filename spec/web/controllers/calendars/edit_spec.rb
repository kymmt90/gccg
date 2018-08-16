RSpec.describe Web::Controllers::Calendars::Edit, type: :action do
  let(:action) { described_class.new }
  let(:params) { Hash[] }

  it 'is successful' do
    response = action.call(params)
    expect(response).to have_http_status :ok
  end
end
