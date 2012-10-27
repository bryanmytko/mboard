require 'digest/md5'
class ApplicationController < ActionController::Base
  protect_from_forgery

  private
  
  def current_user
    @current_user ||= User.find( session[:user_id] ) if session[:user_id]
  end
  helper_method :current_user
  
  def authorize
    redirect_to login_url if current_user.nil?
  end
  
  def is_admin
    return false if session[:user_id].nil?
    admin_status = User.find_by_id( session[:user_id] )
    admin_status.is_admin
  end
  helper_method :is_admin
  
  def is_user_admin( author )
    return false if author.nil?
    admin_status = User.find_by_username( author )
    admin_status.is_admin
  end
  helper_method :is_user_admin
  
  def is_user
    return false if session[:user_id].nil?
    true
  end
  helper_method :is_user
  
  def gravatar_self
    user = User.find_by_id( session[:user_id] )
    gravatar = Digest::MD5.hexdigest( user.email.downcase )
  end
  helper_method :gravatar_self
  
  def gravatar_user( author )
    user = User.find_by_username( author )
    gravatar = Digest::MD5.hexdigest( user.email.downcase )
  end
  helper_method :gravatar_user
  
  def html_parse( s ) 
    
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
    s = s.gsub(/\B()(@[a-zA-Z0-9_-]*.)(\n|\s)??/i) { |x|   
        link = $2
        username = link.gsub(/@/,'')
        user_display = User.find_by_username(username)
        if user_display
          '<a href="/user/' + user_display.username + '" target="_blank">@' + user_display.username + '</a> '
        else
          x
        end
    }

    # replacing newlines to <br> ans <p> tags 
    # wrapping text into paragraph 
    s = "<p>" + s.gsub(/\n\n+/, "</p>\n\n<p>").
            gsub(/([^\n]\n)(?=[^\n])/, '\1<br />') + "</p>" 

    s      
  end 
  helper_method :html_parse
  
end
