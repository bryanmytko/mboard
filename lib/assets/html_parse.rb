class HtmlParser
  
  def self.reply_parse( s )
    
    s.gsub!( /\r\n?/, "\n" ) #converting newlines 
    s = s.to_s.gsub('&', '&amp;').gsub('<', '&lt;').gsub('>', '&gt;') #html entities

    s.gsub!(/\n?&lt;blockquote&gt;\n*(.+?)\n*&lt;\/blockquote&gt;/im, "<blockquote>\\1</blockquote>") #blockquote

    %w(b i em strong u).each { |x|
         s.gsub!(Regexp.new('&lt;(' + x + ')&gt;(.+?)&lt;/('+x+')&gt;',
                 Regexp::MULTILINE|Regexp::IGNORECASE), 
                 "<\\1>\\2</\\1>") 
        } #b, i, em, strong, u 

    s = s.gsub(/&lt;a.+?href\s*=\s*['"](.+?)["'].*?&gt;(.+?)&lt;\/a&gt;/im) { |x|
            '<a href="' + ($1.index('://') ? $1 : 'http://'+$1) + "\">" + $2 + "</a>" 
          } #a | href="" attribute auto-adds http:// 
          
    s = s.gsub(/&lt;img.*?src=['"](.*?)["'].*?&gt;/im) { |x|
           '<a href="' + $1 + '" target="_blank"><img src="' + $1 + '" class="reply_image" /></a>'
         } #img
 
    s = s.gsub(/\B(@[a-zA-Z0-9_-]*.)(\n|\s)??/im) { |x|   
          link = $1
          username = link.gsub(/@/,'').strip
          user_display = User.find_by_username( username.downcase.capitalize )
          if user_display
            '<a href="/user/' + username.downcase.capitalize + '" target="_blank">@' + username + '</a> '
          else
           '@' + username
          end
    } #twitter style @ mentions (only valid usernames!)

    s = "<p>" + s.gsub(/\n\n+/, "</p>\n\n<p>").gsub(/([^\n]\n)(?=[^\n])/, '\1<br />') + "</p>" #newlines

    s
  end
end