require 'digest/md5'

class HomeController < ApplicationController
  before_filter :authorize
  def index
    @user = User.find_by_id(session[:user_id])
    @topics = Topic.find(:all)
  end
end
