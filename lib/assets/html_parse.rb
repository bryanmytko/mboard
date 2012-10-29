class HtmlParser
  
  def self.reply_parse( s )
    
    # converting newlines 
    s.gsub!( /\r\n?/, "\n" ) 

    # escaping HTML to entities 
    s = s.to_s.gsub('&', '&amp;').gsub('<', '&lt;').gsub('>', '&gt;') 

    # blockquote tag support 
    s.gsub!(/\n?&lt;blockquote&gt;\n*(.+?)\n*&lt;\/blockquote&gt;/im, "<blockquote>\\1</blockquote>") 

    # other tags: b, i, em, strong, u 
    %w(b i em strong u).each { |x|
         s.gsub!(Regexp.new('&lt;(' + x + ')&gt;(.+?)&lt;/('+x+')&gt;',
                 Regexp::MULTILINE|Regexp::IGNORECASE), 
                 "<\\1>\\2</\\1>") 
        } 

    # A tag support 
    # href="" attribute auto-adds http:// 
    s = s.gsub(/&lt;a.+?href\s*=\s*['"](.+?)["'].*?&gt;(.+?)&lt;\/a&gt;/im) { |x|
            '<a href="' + ($1.index('://') ? $1 : 'http://'+$1) + "\">" + $2 + "</a>" 
          }
          
    # img tag support
    s = s.gsub(/&lt;img.*?src=['"](.*?)["'].*?&gt;/im) { |x|
           '<a href="' + $1 + '" target="_blank"><img src="' + $1 + '" class="reply_image" /></a>'
         }
 
    #twitter style @at mention
    s = s.gsub(/\B(@[a-zA-Z0-9_-]*.)(\n|\s)??/im) { |x|   
        link = $1
        username = link.gsub(/@/,'')
        #user_display = User.find_by_username( username, :conditions => [ "lower(username) = ?",  username.downcase ] )
        #if user_display
          '<a href="/user/' + username + '" target="_blank">@' + username + '</a> '
       # else
       #   'at' + username
        #end
    }

    # replacing newlines to <br> ans <p> tags 
    # wrapping text into paragraph 
    s = "<p>" + s.gsub(/\n\n+/, "</p>\n\n<p>").
            gsub(/([^\n]\n)(?=[^\n])/, '\1<br />') + "</p>" 

    s
  end
end