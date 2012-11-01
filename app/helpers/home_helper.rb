module HomeHelper
  def reply_count(id)
    Reply.find_all_by_topic_id(id).count
  end
  
  def last_page id
    reply_count( id ) / ENV['reply_pagination_count'].to_i + 1
  end
end
