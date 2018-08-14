RSpec.describe ScheduleDetailRepository, type: :repository do
  let(:repository) { described_class.new }
  let(:schedule) {
    ScheduleRepository.new.create(
      calendar_id: CalendarRepository.new.create(
        title: 'test',
        starts_on: Date.today,
        ends_on: Date.today >> 1
      ).id,
      garbage_id: 1
    )
  }

  describe '#create' do
    let(:params) { { day_of_week: day_of_week, nth_week: nth_week, schedule_id: schedule.id } }

    describe 'day_of_week' do
      let(:nth_week) { 1 }

      context 'when less than 0' do
        let(:day_of_week) { -1 }

        specify {
          expect { repository.create(params) }.to raise_error Hanami::Model::CheckConstraintViolationError
        }
      end

      context 'when 0' do
        let(:day_of_week) { 0 }

        specify { expect { repository.create(params) }.not_to raise_error }
      end

      context 'when 6' do
        let(:day_of_week) { 6 }

        specify { expect { repository.create(params) }.not_to raise_error }
      end

      context 'when greater than 6' do
        let(:day_of_week) { 7 }

        specify {
          expect { repository.create(params) }.to raise_error Hanami::Model::CheckConstraintViolationError
        }
      end
    end

    describe 'nth_week' do
      let(:day_of_week) { 0 }

      context 'when less than 1' do
        let(:nth_week) { 0 }

        specify {
          expect { repository.create(params) }.to raise_error Hanami::Model::CheckConstraintViolationError
        }
      end

      context 'when 1' do
        let(:nth_week) { 1 }

        specify { expect { repository.create(params) }.not_to raise_error }
      end

      context 'when 5' do
        let(:nth_week) { 5 }

        specify { expect { repository.create(params) }.not_to raise_error }
      end

      context 'when greater than 5' do
        let(:nth_week) { 6 }

        specify {
          expect { repository.create(params) }.to raise_error Hanami::Model::CheckConstraintViolationError
        }
      end
    end
  end
end
