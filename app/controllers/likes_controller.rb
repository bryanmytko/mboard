
class LikesController < ApplicationController
  def new
  end
  
  def create
  end
  
  def edit

    @reply = Reply.find_by_id( params[:id] )

    uid = current_user.id.to_s
    if @reply.likes.nil?
      liked_user_array = Array.new
      liked_user_array.push( uid )
      @reply.update_attributes( :likes => liked_user_array )
    elsif !@reply.likes.include?( uid )
      @reply.likes.push( uid )
      @reply.update_attributes( :likes => @reply.likes )
    end
      
  end
end
