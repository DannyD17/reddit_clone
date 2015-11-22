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
  scenario 'It should not allow login with incorrect password' do
    user = FactoryGirl.create(:user, password: 'password')

    visit '/'

    expect(page).to have_link('Login')

    click_link 'Login'

    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'INCORRECT_PASSWORD'

    click_button 'Login'

    expect(page).to have_content('Invalid email or password')

  end
  scenario 'allow logged in user to log out' do
    user = FactoryGirl.create(:user)

    visit login_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    click_button 'Login'

    expect(page).to have_content("Signed in as #{user.email}")

    expect(page).to have_link('Logout')

    click_link 'Logout'

    expect(page).to have_content("#{user.email} had been logged out")
    expect(page).to_not have_content("Welcome back #{user.first_name.capitalize}")
    expect(page).to_not have_content("Signed in as #{user.email}")

  end
end
