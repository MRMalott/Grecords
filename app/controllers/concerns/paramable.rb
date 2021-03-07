# frozen_string_literal: true

# Public: Concern for parameters
module Paramable
  extend ActiveSupport::Concern

  # Public: Takes repeating query params from the request object and flattens them into an array
  def flatten_array_params(param_to_flatten, default = [])
    result = Rack::Utils.parse_query(request.query_string)[param_to_flatten]
    result = [result].compact unless result.is_a? Array # Make sure output is an array
    result.presence || default
  end

  # Public: Transforms all parameter keys from upper or lower camelCase into snake_case
  def transform_param_keys_casing
    params.transform_keys!(&:underscore)
  end
end
