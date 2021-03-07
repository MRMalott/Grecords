# frozen_string_literal: true

# Public: Forms the connection between Record and Artist
# https://guides.rubyonrails.org/association_basics.html#the-has-many-through-association
class ArtistReference < ApplicationRecord
  belongs_to :artist
  belongs_to :record
end
