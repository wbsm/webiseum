class AddAnswerToForecast < ActiveRecord::Migration
  def change
    add_column :forecasts, :answer, :string
  end
end
