# frozen_string_literal: true

class UrlsController < ApplicationController
  RECENT_URLS_COUNT = 30
  def index
    @recent_count = RECENT_URLS_COUNT
    @url = Url.last(RECENT_URLS_COUNT)
  end

  def show
    @url = Url.find_by shortened_url: params[:shortened_url]
  end

  def create
    base_url = params[:url][:base_url] || ''
    @url = Url.find_or_create_by(base_url: base_url)
    if @url.valid?
      redirect_to @url
    else
      flash[:error] = @url.errors.full_messages
      redirect_to root_path
    end
  end
end
