module FeedHelper

  def tag_cloud(tags)
    return unless tags.present?

    rel_order = [4,8,6,2,10,9,2,6,8,4]

    content = '<div id="tag-cloud" class="tag-content"> '

    tags.each_with_index do |tag, index|
      content += link_to tag.name, feed_tags_path(tag.name.downcase), rel: rel_order[index.divmod(10).last]
      content += ' '
    end

    content += '</div>'
    raw content
  end

end
