class AddForecastAnswered < ActiveRecord::Migration
  def change
    add_column :forecasts, :answer_correct, :boolean, null: true
  end
end
