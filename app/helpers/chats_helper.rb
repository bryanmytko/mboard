module ChatsHelper
  def chat_name( id )
    User.find( id ).username
  end
end
