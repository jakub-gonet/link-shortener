# frozen_string_literal: true

class StatsController < ApplicationController
  RECENT_DAYS = 30

  def index
    @urls_views = UrlAccess.count_all_urls_views_since(Date.today - RECENT_DAYS)
  end

  def show
    @shortened_url = params[:shortened_url]
    @url_views = UrlAccess.count_url_views_since(params[:shortened_url],
                                                 Date.today - RECENT_DAYS)
  end
end
