class MeController < ApplicationController
  before_filter :authenticate_user!
  layout "me"
  def index
  end
end
