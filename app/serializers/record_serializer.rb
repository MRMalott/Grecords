# frozen_string_literal: true

class RecordSerializer < ActiveModel::Serializer
  attributes :id, :title, :year, :condition, :description
  has_many :artists
end
