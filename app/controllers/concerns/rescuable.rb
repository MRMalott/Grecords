# frozen_string_literal: true

# Public: Concern for base rescue_froms
module Rescuable
  extend ActiveSupport::Concern

  # Public: Rendering method for 400 errors
  def rescue_bad_request(error)
    render status: :bad_request, json: { code: 400, error: "#{error.class}: #{error}" }
  end
end
