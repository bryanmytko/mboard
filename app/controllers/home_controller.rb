require 'digest/md5'

class HomeController < ApplicationController
  before_filter :authorize
  def index
    @user = User.find_by_id(session[:user_id])
    @topics = Topic.find(:all, :order => 'updated_at DESC')
    @topic = Topic.new
    
    @topics.each do |x|
      if x.topic_counter.nil?
        tc = TopicCounter.new
        tc.topic_id = x.id
        tc.count = x.view_count
        tc.save
      end
    end
    
    
    
    
  end 
end
