module HomeHelper
  def reply_count(id)
    Reply.find_all_by_topic_id(id).count
  end
end
