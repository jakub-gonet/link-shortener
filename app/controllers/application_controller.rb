# frozen_string_literal: true

# Used for handling exceptions raised in other controllers and for showing root path view
class ApplicationController < ActionController::Base
  def index
    render 'index'
  end

  rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid
  rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found

  protected

  def render_record_invalid(exception)
    flash[:error] = exception.record.errors
    redirect_to root_path
  end

  def render_record_not_found(_exception)
    redirect_to controller: :errors, action: :not_found
  end
end
