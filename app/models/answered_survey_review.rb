class AnsweredSurveyReview < ActiveRecord::Base
  belongs_to :service_survey
  belongs_to :user

  scope :unhappy, ->{ where("total_score < ?", 70) }
  scope :happy, ->{ where("total_score >= ?", 85) }
  scope :neutral, ->{ where("total_score BETWEEN ? AND ?", 70, 84.99) }
end
