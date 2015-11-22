require 'rails_helper'

feature 'User authentication' do
  scenario 'It should allow users to signup' do
    user = FactoryGirl.create(:user)

    visit '/'

    expect(page).to have_link('Signup')

    click_link 'Signup'

    fill_in 'First Name', with: user.first_name
    fill_in 'Last Name', with: user.last_name
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password Confirmation', with: user.password

    click_button 'Signup'

    expect(page).to have_content("Thank you for signing up #{user.first_name.capitalize}")
    expect(page).to have_content("Signed in as #{user.email}")

  end
  scenario 'It should allow users to login' do
    user = FactoryGirl.create(:user)

    visit '/'

    expect(page).to have_link('Login')

    click_link 'Login'

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    click_button 'Login'

    expect(page).to have_content("Welcome back #{user.first_name.capitalize}")
    expect(page).to have_content("Signed in as #{user.email}")

  end
end
