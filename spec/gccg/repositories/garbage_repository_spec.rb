RSpec.describe GarbageRepository, type: :repository do
  let(:repository) { described_class.new }

  describe '#combustible' do
    specify { expect(repository.combustible.segregation).to eq 'combustible' }
  end

  describe '#non_combustible' do
    specify { expect(repository.non_combustible.segregation).to eq 'non_combustible' }
  end

  describe '#recyclable' do
    specify { expect(repository.recyclable.segregation).to eq 'recyclable' }
  end
end
