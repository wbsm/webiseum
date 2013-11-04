class Social::SocialController < ApplicationController
  layout 'social'

  before_action :populate_rank, :populate_tags

  private

      def populate_tags
        @tags = Tag.all
      end

      def populate_rank
        @rank = Rank.order('score desc').limit(10)
      end

end