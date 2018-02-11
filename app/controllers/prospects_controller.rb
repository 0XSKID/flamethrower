class ProspectsController < ApplicationController

  def index
    prospects = account.prospects
    render json: prospects
  end

  private

  def account
    @account ||= Account.find(params[:account_id])
  end
end
