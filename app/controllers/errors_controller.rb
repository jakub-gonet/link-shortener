# frozen_string_literal: true

# Used for rendering 404 and 500 error pages
class ErrorsController < ApplicationController
  def not_found
    render status: :not_found
  end

  def internal_server_error
    render status: :internal_server_error
  end
end
