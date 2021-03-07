# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

single_artist_records = Record.create([
                                        {
                                          title: 'Artemis', year: 2019,
                                          condition: 'unplayed', description: '',
                                          artists_attributes: [{
                                            first_name: 'Lindsey', last_name: 'Stirling'
                                          }]
                                        },
                                        {
                                          title: 'Back in Black', year: 1980,
                                          condition: 'unplayed', description: '',
                                          artists_attributes: [{
                                            show_name: 'AC/DC'
                                          }]
                                        }
                                      ])

linkin_park_record = Record.create(
  title: 'Hybrid Theory', year: 2000,
  condition: 3, description: '',
  artists_attributes: [{
    show_name: 'Linkin Park'
  }]
)

Record.create(
  title: 'Hybrid Theory', year: 2000,
  condition: 3, description: '',
  artist_ids: linkin_park_record.artist_ids
)
