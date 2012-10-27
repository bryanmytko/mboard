require 'uri'
module RepliesHelper
  
  class Array
     def included_in? array
       array.to_set.superset?(self.to_set)
     end
  end

  def hyperlink_parser( string )
    URI.extract(string).each do |u|
      formats = ['.jpg','.jpeg','.gif','.png']
      if formats.any? { |w| u[w] } 
        string.gsub!(u,'<img src="' + u + '" />')
      elsif u.include? 'http'
        string.gsub!(u,'<a href="' + u + '">' + u + '</a>')
      end
    end
    string
  end
  
  def is_gif(data)
    return data.include?(".gif")
  end
  
  def at_mention_parse( string )
  end
  
end