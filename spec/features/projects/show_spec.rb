require 'rails_helper'

RSpec.describe "Project show page" do
  describe "When I visit '/projects/:project_id'" do
    it "I see the project's name and material along with the theme of the challenge this project belongs to" do
      
      recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
      boardfit = recycled_material_challenge.projects.create(name: "Boardfit", material: "Cardboard Boxes")
      news_chic = recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")


      visit "/projects/#{news_chic.id}"

      expect(page).to have_content(news_chic.name)
      expect(page).to have_content(news_chic.material)
      expect(page).to have_content(recycled_material_challenge.theme)

      expect(page).to_not have_content(boardfit.name)
      expect(page).to_not have_content(boardfit.material)
    end
  end
end