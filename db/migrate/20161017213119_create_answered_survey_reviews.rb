class CreateAnsweredSurveyReviews < ActiveRecord::Migration
  def change
    create_table :answered_survey_reviews do |t|
      t.decimal :total_score
      t.references :service_survey, index: true
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :answered_survey_reviews, :service_surveys
    add_foreign_key :answered_survey_reviews, :users
  end
end
