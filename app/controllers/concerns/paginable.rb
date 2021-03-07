# frozen_string_literal: true

# Public: Concern for pagination
module Paginable
  extend ActiveSupport::Concern
  LIMIT = 100

  # Public: Provide a default offset of o
  def offset
    (params[:offset].presence || 0).to_i
  end

  # Public: Provide a default limit of 20
  def limit
    (params[:limit].presence || 20).to_i
  end

  # Public: Use to verify pagination params
  def valid_paginate_params?(offset, limit)
    valid_limit?(limit) && valid_offset?(offset)
  end

  def valid_offset?(offset)
    offset.nil? || offset.zero? || offset.positive?
  end

  def valid_limit?(limit)
    limit.nil? || (limit.positive? && limit.to_i <= LIMIT)
  end
end
