require 'spec_helper'

feature "User browses the list of links" do

  scenario "when opening the home page" do
    visit '/'
    sign_up
    add_link
    save_and_open_page
    expect(page).to have_content("Makers Academy")
  end

  def sign_up(email = "alice@example.com", password = "oranges!", password_confirmation = 'oranges!')
    visit '/users/new'
    fill_in :email, :with => email
    fill_in :password, :with => password
    fill_in :password_confirmation, :with => password_confirmation
    click_button "Sign up"
  end

  def add_link(url = "www.makersacademy.com", title = "Makers Academy")
      within('#new-link') do
      fill_in 'url', :with => url
      fill_in 'title', :with => title
      click_button 'Add link'
    end      
  end

end


