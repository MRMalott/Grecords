# frozen_string_literal: true

# Public: Base error class. These errors are rescued in the application controller
module Errors
  class BadRequestError < StandardError
  end
end
