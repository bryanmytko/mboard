module ApplicationHelper
  def broadcast( channel, &block )
    message = { :ext => {:auth_token => "fidelio"}, :channel => channel, :data => capture( &block ) }
    uri = URI.parse( ENV['FAYE_PATH'] )
    Net::HTTP.post_form( uri, :message => message.to_json )
  end
end