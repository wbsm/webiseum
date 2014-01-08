class Social::SocialController < ApplicationController
  layout 'social'

  before_action :populate_rank, :populate_tags, :verify_logged_user

  private

      def populate_tags
        @tags = Tag.all
      end

      def populate_rank
        @rank = Rank.order('score desc').limit(10)
      end

      def verify_logged_user

        @logged_user = User.find_by_id(session[:user_id])
        if @logged_user.nil?
          redirect_to unregistered_path
        end

      end

end