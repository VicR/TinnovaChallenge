require 'rails_helper'

RSpec.describe Beer, type: :model do
  describe 'validations' do
    context 'valid' do
      it 'should create' do
        b = build(:beer)
        expect(b.save).to eq(true)
      end
    end
    context 'invalid' do
      it 'shouldn\'t create with invalid name' do
        bad = build(:beer, name: nil)
        expect(bad.save).to eq(false)
      end
      it 'shouldn\'t create with invalid tagline' do
        bad = build(:beer, tagline: nil)
        expect(bad.save).to eq(false)
      end
      it 'shouldn\'t create with invalid description' do
        bad = build(:beer, description: nil)
        expect(bad.save).to eq(false)
      end
      it 'shouldn\'t create with invalid abv' do
        bad = build(:beer, abv: nil)
        expect(bad.save).to eq(false)
      end
      it 'shouldn\'t create with non-numeric abv' do
        bad = build(:beer, abv: 'Blabla')
        expect(bad.save).to eq(false)
      end
      it 'shouldn\'t create with invalid seen_at' do
        bad = build(:beer, seen_at: nil)
        expect(bad.save).to eq(false)
      end
    end
  end
end
