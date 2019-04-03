# frozen_string_literal: true

# Takes care of redirection of shortened urls
class RedirectsController < ApplicationController
  def show
    url = Url.find_by!(shortened_url: params[:shortened_url])

    UrlAccess.create!(url_id: url.id, ip: request.remote_ip)
    redirect_to url.base_url
  end
end
