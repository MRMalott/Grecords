# frozen_string_literal: true

# Public: Base controller
class ApplicationController < ActionController::API
  include Paginable
  include Paramable
  include Rescuable

  before_action :transform_param_keys_casing

  rescue_from Errors::BadRequestError, with: :rescue_bad_request
end
