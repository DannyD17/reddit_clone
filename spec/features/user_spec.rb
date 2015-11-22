require 'rails_helper'

feature 'User authentication' do
  scenario 'It should allow users to sign up' do
    user = FactoryGirl.create(:user)

    visit '/'

    expect(page).to have_link('Signup')

    click_link 'Signup'

    fill_in 'First Name', with: user.first_name
    fill_in 'Last Name', with: user.last_name
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password Confirmation', with: user.password

    click_link 'Signup'

    expect(page).to have_content("Thank you for signing up #{user.first_name.capitalize}")
    expect(page).to have_content("You are signed in as #{user.email}")

  end
end
