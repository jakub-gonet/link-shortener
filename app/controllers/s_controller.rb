# frozen_string_literal: true

class SController < ApplicationController
  def show
    url = Url.find_by shortened_url: params[:id]
    if !url.nil?
      redirect_to url.base_url
    else
      redirect_to root_path, alert: 'Requested URL not found'
    end
  end
end