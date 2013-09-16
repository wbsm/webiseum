class Admin::RankingGeneratorController < Admin::AdminController

  def generate

    questions_to_generate_rank = Question.includes(:forecasts).includes(:users).where(:rank_update => false).where.not(:correct_answer => '')

    # fazer associacao de previsoes respondidas certas para geracao de ranking.
    questions_to_generate_rank.each do |q|

      correct_answer = q.correct_answer

      q.forecasts.each do |f|
        if correct_answer == f.answer
          f.user.rank_score += f.rating
          f.user.save
        end
      end

      q.rank_update = true
      q.save
    end

    redirect_to admin_dashboard_index_path, notice: 'Ranking atualizado com sucesso...'
  end

end