# frozen_string_literal: true

class RedirectsController < ApplicationController
  def show
    url = Url.find_by!(shortened_url: params[:shortened_url])

    UrlAccess.new!(url_id: url.id, ip: request.remote_ip)
    redirect_to url.base_url
  end
end
