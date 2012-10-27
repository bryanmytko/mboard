
class NotificationsController < ApplicationController
  def show
    @mentions = Mention.find_all_by_username( current_user.username )
  end
end