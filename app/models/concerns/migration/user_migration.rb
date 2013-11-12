module Migration::UserMigration
  extend ActiveSupport::Concern

  module ClassMethods
    def migrate(auth)
      if auth.nil? || auth.provider != 'facebook'
        return
      end

      user_migrated = ActiveRecord::Base.connection.execute("select * from users_migration_temp where facebook_id = #{auth.uid} and migrated = false")

      user_migrated.each do |user|
        rank_geral = 0

        ranks_migrated = ActiveRecord::Base.connection.execute("select * from ranks_migration_temp where facebook_id = #{user['facebook_id']}")

        ranks_migrated.each do |rank|
          tag = Tag.find_by_name(rank['tag_name'])
          TagRank.create(:user_id => auth.user.id, :tag_id => tag.id, :score => rank['score'])
          rank_geral += (rank['score'].to_i)
        end

        rank = Rank.find_by_user_id(auth.user.id)
        if rank.present?
          rank.score += rank_geral
          rank.save
        else
          rank = Rank.create(:user_id => user_id, :score => rank_geral)
        end

        user_db = auth.user
        user_db.created_at = user['created_at']
        user_db.save
      end

      user_migrated = ActiveRecord::Base.connection.execute("update users_migration_temp set migrated = true where facebook_id = #{auth.uid}")
    end
  end

end