require "spec_helper"

feature "user adds a new TV show" do
  # As a TV fanatic
  # I want to add one of my favorite shows
  # So that I can encourage others to binge watch it
  #
  # Acceptance Criteria:
  # * I must provide the title, network, and starting year.
  # * I can optionally provide the final year, genre, and synopsis.
  # * The synopsis can be no longer than 5000 characters.
  # * The starting year and ending year (if provided) must be
  #   greater than 1900.
  # * The genre must be one of the following: Action, Mystery,
  #   Drama, Comedy, Fantasy
  # * If any of the above validations fail, the form should be
  #   re-displayed with the failing validation message.

  scenario "successfully add a new show" do
    visit "television_shows/new"
    fill_in "Title:", with: "Futurama"
    fill_in "Network:", with: "Fox"
    fill_in "Starting Year:", with: "2000"
    fill_in "Ending Year:", with: "2010"
    select "Comedy", from: "Genre:"
    fill_in "Synopsis:", with: "Best show ever."
    click_button "Add TV Show"
    expect(page).to have_content("Futurama")
    expect(page).to have_content("Fox")
    expect(page).to have_content("2000 - 2010")
    expect(page).to have_content("Comedy")
    expect(page).to have_content("Best show ever.")
  end

  scenario "fail to add a show with invalid information" do
    visit "television_shows/new"
    fill_in "Network:", with: "Fox"
    fill_in "Starting Year:", with: "Simpsons"
    fill_in "Ending Year:", with: "2010"
    select "Comedy", from: "Genre:"
    fill_in "Synopsis:", with: "Best show ever."
    click_button "Add TV Show"
    expect(page).to have_content("Title can't be blank")
    expect(page).to have_content("Starting year is not a number")
  end

end

