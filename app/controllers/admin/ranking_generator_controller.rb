class Admin::RankingGeneratorController < Admin::AdminController

  def generate

    questions_to_generate_rank = Question.includes(:forecasts).includes(:users).where(:rank_update => false).where.not(:correct_answer => '')

    # fazer associacao de previsoes respondidas certas para geracao de ranking.
    questions_to_generate_rank.each do |q|

      correct_answer = q.correct_answer

      scoreMultiply = [10, 15, 20, 25, 30]

      q.forecasts.each do |f|

        user_id = f.user.id
        rating = f.rating - 1

        is_correct = correct_answer == f.answer

        # rank geral
        rank = Rank.find_or_create_by(:user_id => user_id)
        is_correct ? rank.score += scoreMultiply[rating] : rank.score += (scoreMultiply[rating]*-1)
        rank.save

        # rank by tags
        f.question.tags.each do |tag|
          tag_rank = TagRank.find_or_create_by(:user_id => user_id, :tag_id => tag.id)

          is_correct ? tag_rank.score += scoreMultiply[rating] : tag_rank.score -= scoreMultiply[rating]
          tag_rank.save
        end

      end

      q.rank_update = true
      q.save
    end

    respond_to do |format|
      format.js
    end
  end

end