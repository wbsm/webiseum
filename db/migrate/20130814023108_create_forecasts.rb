class CreateForecasts < ActiveRecord::Migration
  def change
  	
    create_table :forecasts do |t|
      t.integer :rating
      t.text :comment

      t.belongs_to :user
      t.belongs_to :question

      t.timestamps
    end

    create_table :questions do |t|
      t.string :title
      t.text :description
      t.datetime :publish_at
      t.datetime :finish_at
      t.datetime :event_at
      t.text :answers
      t.string :correct_answer
      t.binary :image

      t.timestamps
  end

  create_table :users do |t|
      t.string :full_name
      t.string :email
      t.string :password_digest
      
      t.timestamps
    end

    create_table :questions_tags do |t|
      t.belongs_to :question
      t.belongs_to :tag
    end
  end
end
