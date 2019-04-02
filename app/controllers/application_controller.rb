# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def index
    render 'index'
  end

  rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid

  def render_record_invalid(exception)
    flash[:error] = exception.record.errors
    redirect_to root_path, status: :bad_request
  end
end
