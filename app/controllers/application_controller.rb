# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def index
    render 'index'
  end

  rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid
  rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found

  protected

  def render_record_invalid(exception)
    redirect_to controller: :errors, action: :internal_server_error
  end

  def render_record_not_found(exception)
    redirect_to controller: :errors, action: :not_found
  end
end
