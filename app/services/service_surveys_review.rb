module ServiceSurveysReview
  def self.review_for_survey(service, report)
    ServiceReview.new(service, report)
  end

  def self.create_review_for(answers, survey_id, review_store)
    total = answers.sum(&:score)
    review_store.create(
      total_score: total,
      user_id: answer.first[:user_id],
      service_survey_id: survey_id)
  end

  private

  class ServiceReview < Struct.new(service, report)
    def title
      service.name
    end

    def evaluators_count
      service.answered_surveys
    end

    def happy_percentage
      (service.answered_survey_reviews.happy.count * 100.0) / service.answered_survey_reviews_count
    end

    def neutral_percentage
      (service.answered_survey_reviews.neutral.count * 100.0) / service.answered_survey_reviews_count
    end

    def unhappy_percentage
      (service.answered_survey_reviews.unhappy.count * 100.0) / service.answered_survey_reviews_count
    end
  end
end