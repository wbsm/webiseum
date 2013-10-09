module FeedHelper

  def tag_claud(tags)
    rel_order = [4,8,6,2,10,9,2,6,8,4];
    content = '<div id="tag-cloud"> '
    unless tags.present?
      content = link_to 'Questões cadastradas', '/in'
      raw content
    end

    tags.each_with_index do |tag, index|
      content += link_to tag.name, tag_social_feed_path(tag.name.downcase), rel: rel_order[index.divmod(10).last]
      content += ' '
    end

    content += '</div>'
    raw content
  end

end