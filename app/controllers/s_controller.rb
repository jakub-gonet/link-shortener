# frozen_string_literal: true

class SController < ApplicationController
  def show
    url = Url.find_by shortened_url: params[:shortened_url]
    if !url.nil?
      access = UrlAccess.new(url_id: url.id, ip: request.remote_ip)
      unless access.save
        logger.warn("Couldn't save access for ip #{request.remote_ip}, id: #{url.id}")
      end
      redirect_to url.base_url
    else
      redirect_to root_path, alert: 'Requested URL not found'
    end
  end
end