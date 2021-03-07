# frozen_string_literal: true

class CreateArtists < ActiveRecord::Migration[5.2]
  def change
    create_table :artists do |t|
      t.string :first_name
      t.string :last_name
      t.string :show_name

      t.timestamps
    end
  end
end
