# frozen_string_literal: true

# Used in creation of new shortened urls and showing theirs detailed info
class UrlsController < ApplicationController
  RECENT_URLS_COUNT = 30
  def index
    @recent_count = RECENT_URLS_COUNT
    @url = Url.last(RECENT_URLS_COUNT)
  end

  def show
    @url = Url.find_by!(shortened_url: params[:shortened_url])
  end

  def create
    @url = Url.find_or_create_by!(url_params)
    redirect_to @url
  end

  private

  def url_params
    params.require(:url).permit(:base_url)
  end
end
