# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def index
    render 'index'
  end

  rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid
  rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found

  protected

  def render_record_invalid(exception)
    flash[:error] = exception.record.errors
    redirect_to root_path, status: :bad_request
  end

  def render_record_not_found(exception)
    flash[:error] = exception.to_s
    logger.info(exception)
    redirect_to root_path
  end
end
