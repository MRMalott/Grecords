# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Record, type: :model do
  subject { record }
  let(:record) { create(:record) }

  it { should have_many(:artists).through(:artist_references) }
  it { should have_many(:artist_references) }
  it { should validate_presence_of(:title) }
  it { should accept_nested_attributes_for(:artists) }
  it { should validate_length_of(:title).is_at_most(191) }
  it { should validate_length_of(:description).is_at_most(1000) }
  it { should validate_numericality_of(:year).is_greater_than(1876) }
end
