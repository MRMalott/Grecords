# frozen_string_literal: true

class CreateArtistReferences < ActiveRecord::Migration[5.2]
  def change
    create_table :artist_references do |t|
      t.belongs_to :artist
      t.belongs_to :record
      # t.integer :featured could allow looking up via them being featured

      t.timestamps
    end
  end
end
