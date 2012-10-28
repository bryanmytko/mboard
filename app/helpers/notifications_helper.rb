module NotificationsHelper
  def thread_link_format string
    #yuck. should be better regex. tired.
    string = string.gsub(/^.*\/(.*\?.*|.*)/im) { |t| $1 }
    string.gsub(/\?.*/,'')
  end
end
