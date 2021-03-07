# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Artist, type: :model do
  subject { artist }
  let(:artist) { create(:artist) }

  it { should have_many(:records).through(:artist_references) }
  it { should have_many(:artist_references) }

  describe '#name_provided?' do
    context 'when all names are blank' do
      let(:artist) { create(:artist, first_name: '', last_name: '', show_name: '') }

      it 'throws validation exception' do
        expect { subject }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'when all names are nil' do
      let(:artist) { create(:artist, first_name: nil, last_name: nil, show_name: nil) }
      it 'throws validation exception' do
        expect { subject }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'when 2 names are blank' do
      let(:artist) { create(:artist, first_name: '', last_name: '', show_name: 'name') }
      it 'creates with no validation errors' do
        expect { subject }.to_not raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'when one name is blank' do
      let(:artist) { create(:artist, first_name: '', last_name: 'name', show_name: 'name') }
      it 'creates with no validation errors' do
        expect { subject }.to_not raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe 'validates_length' do
    subject { artist }
    let(:artist) { create(:artist, first_name: first_name, last_name: last_name, show_name: show_name) }
    let(:first_name) { 'first' }
    let(:last_name) { 'last' }
    let(:show_name) { 'show' }

    context 'when first name is too long' do
      let(:first_name) { Faker::Lorem.characters(192) }
      it 'throws validation exception' do
        expect { subject }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'when last name is too long' do
      let(:last_name) { Faker::Lorem.characters(192) }
      it 'throws validation exception' do
        expect { subject }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'when show name is too long' do
      let(:show_name) { Faker::Lorem.characters(192) }
      it 'throws validation exception' do
        expect { subject }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
