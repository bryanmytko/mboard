
class ChatsController < ApplicationController
   def index
     @chats = Chat.all
   end

   def create
     params[:chat][:username] = session[:user_id]
     @chat = Chat.create!( params[:chat] )
   end

  def new
  end
end
