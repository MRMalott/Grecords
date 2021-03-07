# frozen_string_literal: true

# Public: Artist model
class Artist < ApplicationRecord
  has_many :artist_references, dependent: :destroy
  has_many :records, through: :artist_references

  validate :name_provided
  validates :first_name, :last_name, :show_name, length: { maximum: 191 }

  private

  # Internal: Determines that at least one name attribute has been given
  def name_provided
    name_present = first_name.present? || last_name.present? || show_name.present?
    errors.add(:names, ', at least one name must be provided') unless name_present
  end
end
