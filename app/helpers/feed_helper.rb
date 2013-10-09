module FeedHelper

  def tag_claud(tags)
    rel_order = [4,8,6,2,10,9,2,6,8,4];
    content = '<div id="tag-cloud"> '
    unless tags.present?
      content += link_to 'Webiseum', social_feed_index_path, rel: 10
      content += ' </div>'
      raw content and return
    end

    tags.each_with_index do |tag, index|
      content += link_to tag.name, tag_social_feed_path(tag.name.downcase), rel: rel_order[index.divmod(10).last]
      content += ' '
    end

    content += '</div>'
    raw content
  end

end
