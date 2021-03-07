# frozen_string_literal: true

class CreateRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :records do |t|
      t.string :title, null: false, limit: 191
      t.integer :year
      t.integer :condition, default: 0, null: false
      t.text :description

      t.timestamps
    end
  end
end
