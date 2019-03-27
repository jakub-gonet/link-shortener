# frozen_string_literal: true

class UrlsController < ApplicationController

  def show
    @url = Url.find(params[:id])
  end
end
