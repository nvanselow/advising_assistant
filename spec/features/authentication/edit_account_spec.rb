require 'rails_helper'

feature 'user can edit their account information', %{
  As a user
  I want to edit my account information
  So that I can update my information if it changes
} do
  # ACCEPTANCE CRITERIA
  # [ ] I can edit my account my clicking my name in the navbar
  # [ ] I can see a success message if I edit my account correctly
  # [ ] I see an error message indicating what to fix if I make an
  #     invalid change

  let(:user) { FactoryGirl.create(:user) }
  let(:updated_user) { FactoryGirl.attributes_for(:user) }

  before do
    sign_in user
  end

  scenario 'user navigates to account edit form from navbar' do
    visit root_path

    click_link user.email

    expect(page).to have_content('Edit Account Information')
    expect(page).to have_css('form')
  end

  scenario 'user edits account correctly' do
    visit edit_user_registration_path

    fill_in('Email', with: updated_user[:email])
    fill_in('First Name', with: updated_user[:first_name])
    fill_in('Last Name', with: updated_user[:last_name])
    fill_in('Current Password', with: user.password)
    click_button('Update')

    expect(page).to have_content(updated_user[:email])

    visit edit_user_registration_path

    expect(find_field('Email').value).to have_content(updated_user[:email])
    expect(find_field('First Name').value).
             to have_content(updated_user[:first_name])
    expect(find_field('Last Name').value).
             to have_content(updated_user[:last_name])
  end

  scenario 'user edits account incorrectly' do
    visit edit_user_registration_path

    fill_in('Email', with: '')
    fill_in('First Name', with: '')
    fill_in('Last Name', with: '')
    fill_in('Current Password', with: user.password)
    click_button('Update')

    expect(page).to have_content('There were 3 errors creating your account')
    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("First name can't be blank")
    expect(page).to have_content("Last name can't be blank")
  end
end
