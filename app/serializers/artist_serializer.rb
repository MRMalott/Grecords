# frozen_string_literal: true

class ArtistSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :show_name
end
