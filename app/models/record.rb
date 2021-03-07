# frozen_string_literal: true

# Public: Record model class
class Record < ApplicationRecord
  has_many :artist_references, dependent: :destroy # Should expect at least one artist, what if unknown?
  has_many :artists, through: :artist_references
  accepts_nested_attributes_for :artists

  validates :title, presence: true, length: { maximum: 191 }
  validates :year, numericality: { greater_than: 1876 } # records invented in 1877
  validates :description, length: { maximum: 1000 }

  enum condition: { unlisted: 0, unplayed: 1, used: 3, unplayable: 5 } # Leaving room for future conditions

  # Allow easy filtering of records by artist
  scope :filter_by_artist,
        lambda { |artist_ids|
          joins(:artists).where(artists: { id: artist_ids }) if artist_ids.present?
        }

  # Public: Simple function that pulls titles, splits them, and keeps count of each word
  def self.most_common_word
    titles = Record.pluck(:title)
    counting_list = {}
    titles.each do |title|
      parts = title.split(' ') # Thought: could consider removing commas periods etc
      parts.each do |word|
        counting_list[word] = counting_list[word].blank? ? 1 : counting_list[word] + 1
      end
    end

    max_count = 0
    common_word = ''
    counting_list.each do |word, count|
      if count > max_count
        common_word = word
        max_count = count
      end
    end

    common_word
  end

  # Public: Ability to filter records down to a subset based on where clauses
  # Thought: Could support limit and offset here for quicker querries
  # Thought: Could move the filtering and aggregate functionality to a concern if needed
  #
  # where - The array of equivalency checks added together via ORs
  def self.filter_records(where:)
    validate_aggregate_params!(where: where)
    Record.joins(:artists).where(where_clause(where))
  end

  # Public: Ability to call aggregate function on RecordsController
  # function - The aggregate function to call at the end
  # where    - The array of equivalency checks added together via ORs
  #          - eg: records.title:like:Back
  def self.aggregate(function:, where:)
    filter_records(where: where).send(function)
  end

  # Public: Ability to call aggregate function on RecordsController with a grouping in mind
  #
  # function - The aggregate function to call at the end
  # where    - The array of equivalency checks added together via ORs
  # group_by - Whether things need to be grouped
  def self.aggregate_by_group(function:, where:, group_by:)
    filter_records(where: where).group_by(&group_by.to_sym).map do |group, records|
      { "#{group}": records.send(function) }
    end
  end

  # Internal: Raises BadRequestError if any of the aggregate parameters are don't meet specifications
  #
  # function - The aggregate function aligning to a supported list
  # where    - The array of equivalency checks 'key:check:values' that match supported attributes and are not blank
  # group_by - Must match the supported attributes of arists and records
  def self.validate_aggregate_params!(where:, function: nil, group_by: nil)
    validate_function!(function: function)
    validate_where!(where: where)
    validate_group_by!(group_by: group_by)
  end

  def self.validate_function!(function: nil)
    function_msg = "Function #{function} not supported"
    raise RecordErrors::BadRequestError, function_msg unless function.blank? || function.in?(['count'])
  end

  def self.validate_where!(where: nil)
    record_names = attribute_names.map { |x| "records.#{x}" }
    specific_allowed_names = record_names + Artist.attribute_names.map { |x| "artists.#{x}" }
    allowed_expressions = ['=', 'like']
    where.each do |clause|
      where_msg = "Where #{clause} not properly formatted"
      raise RecordErrors::BadRequestError, where_msg unless clause.split(':').length == 3

      raise RecordErrors::BadRequestError, where_msg unless clause.split(':')[0].in? specific_allowed_names
      raise RecordErrors::BadRequestError, where_msg unless clause.split(':')[1].in? allowed_expressions
      raise RecordErrors::BadRequestError, where_msg if clause.split(':')[2].blank?
    end
  end

  def self.validate_group_by!(group_by: nil)
    allowed_names = attribute_names + Artist.attribute_names
    group_msg = "Group by #{group_by} not supported"
    raise RecordErrors::BadRequestError, group_msg unless group_by.blank? || group_by.in?(allowed_names)
  end

  # Internal: Takes array of : separated strings and transfers them into a sql key = value with OR separators
  #
  # where_statements - ['artists.first_name:like:Lindsey', 'artists.last_name:like:Stirling']
  #
  # "artists.first_name='Lindsey' || artists.last_name='Stirling'"
  def self.where_clause(where_statements = [])
    where_statements.map do |clause|
      parts = clause.split(':')
      "#{parts[0]} #{parts[1]} '#{parts[2]}'"
    end.join(' || ')
  end
end
