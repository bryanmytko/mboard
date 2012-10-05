require 'uri'
module RepliesHelper
  def hyperlink_parser( string )
    #string.gsub(/((\w+\.){1,3}\w+\/\w+[^\s]+)/) {|x| is_tld?(x) ? "<a href='#{x}' class='#{link_class}'>#{x}</a>" : x}
    URI.extract(string).each do |u|
      string.gsub!(u,'<a href="' + u + '">' + u + '</a>')
    end
    string
  end
end
