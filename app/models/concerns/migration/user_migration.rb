module Migration::UserMigration
  extend ActiveSupport::Concern

  module ClassMethods
    def migrate(auth)
      if auth.nil? || auth.provider != 'facebook'
        return
      end


      # migrate user
      user_migrated = ActiveRecord::Base.connection.execute("select * from users_migration_temp where facebook_id = #{auth.uid} and migrated = false LIMIT 1")

      user_migrated.each do |user|
        raise ActiveRecord::Rollback, "UserMigration: auth.user not found" if auth.nil? || auth.user.nil? || auth.user.id.nil?

        user_db = auth.user
        rank_geral = 0

        # migrate user tag rank
        ranks_migrated = ActiveRecord::Base.connection.execute("select * from ranks_migration_temp where facebook_id = #{user['facebook_id']}")

        ranks_migrated.each do |rank|
          tag = Tag.find_by_name(rank['tag_name'])
          TagRank.create(:user_id => user_db.id, :tag_id => tag.id, :score => rank['score'])
          rank_geral += (rank['score'].to_i)
        end

        # migrate user rank
        rank = Rank.find_by_user_id(user_db.id)
        if rank.present?
          rank.score += rank_geral
          rank.save
        else
          Rank.create(:user_id => user_db.id, :score => rank_geral)
        end

        user_db.created_at = user['created_at']
        user_db.save

        user_migrated = ActiveRecord::Base.connection.execute("update users_migration_temp set migrated = true where facebook_id = #{auth.uid}")

        # migrate user forecasts
        forecast_migrate = ActiveRecord::Base.connection.execute("select * from forecast_migration_temp where facebook_id = #{user['facebook_id']}")
        forecast_migrate.each_with_index do |forecast, index|
          forecast_web = Hash.new
          forecast_web['user_id'] = user_db.id
          forecast_web['question_id'] = forecast_migrate.to_a[index]['question_id']
          forecast_web['answer'] = forecast_migrate.to_a[index]['answer']
          forecast_web['rating'] = forecast_migrate.to_a[index]['rating']
          forecast_web['comment'] = forecast_migrate.to_a[index]['comment']

          Forecast.match(forecast_web)
        end

      end

    end
  end

end