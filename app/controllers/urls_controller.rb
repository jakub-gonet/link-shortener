# frozen_string_literal: true

class UrlsController < ApplicationController
  def index

  end

  def show
    @url = Url.find_by shortened_url: params[:shortened_url]
  end

  def create
    base_url = params[:url][:base_url] || ''
    @url = Url.find_or_create_by(base_url: base_url) do |url|
      url.shortened_url = ShortenedLinksGenerator.shorten(base_url)
    end
    if @url.valid?
      redirect_to @url
    else
      flash[:error] = @url.errors.full_messages
      redirect_to root_path
    end
  end
end
