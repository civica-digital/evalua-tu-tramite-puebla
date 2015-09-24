class AddCisToSurveyReports < ActiveRecord::Migration
  def up
    add_column :service_survey_reports, :cis_id, :integer
  end

  def down
    remove_column :service_survey_reports, :cis_id, :integer
  end
end
