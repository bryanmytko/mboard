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
  
  def user_has_liked( obj )
    unless obj.likes.nil?
      if obj.likes.include? current_user.id.to_s
        return true
      end
    end
    false
  end
      
  
  def likes_count( obj )
    obj.likes.nil? ? 0 : obj.likes.length
  end
  
  def likes_count_text( obj )
    unless obj.likes.nil?
      (obj.likes.length) == 1 ? '1 Person like this.' : obj.likes.length.to_s + ' People like this.'
    else
      '0 People like this.'
    end
  end
  
  def like_people_list( obj )
    if obj.likes
      string = '<div class="like_names clearfix"><ul>'
      case obj.likes.length
        when 0 then return string = ''
        when 1..4 then
          obj.likes.each do |l|
            string += "<li>#{User.find(l).username}</li>"
          end
        else
          4.times do |l|
            string += "<li>#{User.find(obj.likes[l]).username}</li>"
          end
          remaining = obj.likes.length - 4
          string += "<li>And #{remaining} more</li>"
      end
      return  string += '</ul></div>'
  	end
  end

   
end