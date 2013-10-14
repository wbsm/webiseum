class Social::SocialController < ApplicationController
  before_action :populate_common_models

  private
    def populate_common_models
      @rank = Rank.order('score desc').limit(10)
      @tags = Tag.all
    end

end