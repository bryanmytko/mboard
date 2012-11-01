require 'digest/md5'

class HomeController < ApplicationController
  before_filter :authorize
  def index
    @user = User.find_by_id( session[:user_id] )
    @topics = Topic.find( :all, :order => 'updated_at DESC' )
    @topic = Topic.new
    @q = Topic.ransack(params[:q])
    @topics = @q.result(:distinct => true).order( 'updated_at DESC' )
  end 
end
