module ApplicationHelper
  def broadcast( channel, &block )
    message = { :ext => {:auth_token => "fidelio"}, :channel => channel, :data => capture( &block ) }
    uri = URI.parse( 'http://fidelio-faye.herokuapp.com/faye' )
    Net::HTTP.post_form( uri, :message => message.to_json )
  end
end