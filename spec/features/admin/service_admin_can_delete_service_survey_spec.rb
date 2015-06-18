require 'spec_helper'

feature 'As a service admin I can delete a survey' do

  let(:admin) { create(:admin, :service_admin) }

  background do
    sign_in_admin admin
  end

  scenario 'Assigned to a service' do
    service_survey = create :survey_with_binary_question, title: "Survey to delete", admin: admin

    visit admins_service_surveys_path
    expect(page).to have_content "Survey to delete"

    click_link "Eliminar"
    expect(page).to have_content "La encuesta se ha eliminado exitosamente."
    expect(page).not_to have_content "Survey to delete"
    expect(current_path).to eq admins_service_surveys_path
  end
end