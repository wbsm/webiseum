class Social::SocialController < Infra::WebiseumMainController
  before_action :populate_common_models

  private
    def populate_common_models
      @rank = User.order('rank_score desc').limit(10)
    end

end