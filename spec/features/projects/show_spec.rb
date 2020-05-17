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

    it "Shows the number of contestants on the project" do

      recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
      boardfit = recycled_material_challenge.projects.create(name: "Boardfit", material: "Cardboard Boxes")

      jay = Contestant.create(name: "Jay McCarroll", age: 40, hometown: "LA", years_of_experience: 13)
      gretchen = Contestant.create(name: "Gretchen Jones", age: 36, hometown: "NYC", years_of_experience: 12)

      ContestantProject.create(contestant_id: jay.id, project_id: boardfit.id)
      ContestantProject.create(contestant_id: gretchen.id, project_id: boardfit.id)

      visit "/projects/#{boardfit.id}"

      expect(boardfit.contestants.count_of_contestants).to eq(2)
      expect(page).to have_content(boardfit.contestants.count_of_contestants)
    end 

    it "Shows the average years of experience for the contestants that worked on the project" do

      recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
      boardfit = recycled_material_challenge.projects.create(name: "Boardfit", material: "Cardboard Boxes")

      jay = Contestant.create(name: "Jay McCarroll", age: 40, hometown: "LA", years_of_experience: 13)
      gretchen = Contestant.create(name: "Gretchen Jones", age: 36, hometown: "NYC", years_of_experience: 12)

      ContestantProject.create(contestant_id: jay.id, project_id: boardfit.id)
      ContestantProject.create(contestant_id: gretchen.id, project_id: boardfit.id)

      visit "/projects/#{boardfit.id}"

      expect(page).to have_content(boardfit.contestants.average_years_of_experience.round(2))
    end 

    xit "Has a form to add existing contesant to a project" do

      recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
      boardfit = recycled_material_challenge.projects.create(name: "Boardfit", material: "Cardboard Boxes")

      jay = Contestant.create(name: "Jay McCarroll", age: 40, hometown: "LA", years_of_experience: 13)
      gretchen = Contestant.create(name: "Gretchen Jones", age: 36, hometown: "NYC", years_of_experience: 12)
      new_contestant = Contestant.create(name: "New Contestant", age: 36, hometown: "NYC", years_of_experience: 12)

      ContestantProject.create(contestant_id: jay.id, project_id: boardfit.id)
      ContestantProject.create(contestant_id: gretchen.id, project_id: boardfit.id)

      visit "/projects/#{boardfit.id}"

      fill_in :id, with: "#{new_contestant.id}"
      click_button "Add Contestant to Project"

      expect(boardfit.contestants.count_of_contestants).to eq(3)
    end 
  end
end