require 'rails_helper'

feature 'Add a photo to an advisee', %{
  As a user
  I want to add a photo to my advisees
  So that I can figure out who just showed up at my office
} do
  # ACCEPTANCE CRITERIA
  # [ ] I can upload a photo when I create an advisee
  # [ ] I can upload a photo weh I edit an advisee
  # [ ] If I don't upload a photo, I will see a gravatar photo

  let(:user) { FactoryGirl.create(:user) }
  let(:sample_photo) { "#{Rails.root}/spec/support/images/sample_avatar.jpg" }
  let(:advisee_without_photo) do
    FactoryGirl.create(:advisee, user: user, photo: nil)
  end

  before do
    sign_in user
  end

  scenario 'User adds a photo when creating an advisee' do
    advisee = FactoryGirl.attributes_for(:advisee)

    visit new_advisee_path

    fill_in('First Name', with: advisee[:first_name])
    fill_in('Last Name', with: advisee[:last_name])
    fill_in('Email', with: advisee[:email])
    select(advisee[:graduation_semester],
           from: 'advisee_graduation_semester')
    fill_in('Graduation Year', with: advisee[:graduation_year])
    attach_file('advisee_photo', sample_photo)

    click_button('Save Advisee')

    expect_photo(find('.photo img'))
  end

  scenario 'User adds a photo when editing an advisee' do
    visit edit_advisee_path(advisee_without_photo)

    attach_file('advisee_photo', sample_photo)
    click_button('Save Advisee')

    expect_photo(find('.photo img'))
  end

  scenario 'No photo has been uploaded, so gravatar image is displayed' do
    visit advisee_path(advisee_without_photo)

    photo_src = find('.photo img')['src']
    expect(photo_src).to include('https://www.gravatar.com/avatar')
  end
end

def expect_photo(photo)
  photo_src = photo['src']
  expect(photo_src).to have_content("/sample_avatar.jpg")
end
