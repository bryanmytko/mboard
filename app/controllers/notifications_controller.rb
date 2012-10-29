
class NotificationsController < ApplicationController
  def show
    @mentions = Mention.find_all_by_username( current_user.username )
  end
  
  def destroy
    @mention = Mention.find_by_id( params[:id] )
    redirect_path = @mention.thread_link
    if @mention.destroy
      redirect_to root_url + redirect_path
    end
  end
end