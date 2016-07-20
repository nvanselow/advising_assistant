require 'rails_helper'

feature 'User can view notes for an advisee', %{
  As an advisor
  I want to see notes for one of my advisees
  So that I can review the notes I have left for that advisee
} do
  # ACCEPTANCE CRITERIA
  # [X] On the details page for an advisee, I can see all the notes I have
  #     left for that advisee
  # [X] Notes are ordered with the most recent at the top
  # [X] There is a message about the lack of notes if there are none

  let(:user) { FactoryGirl.create(:user) }
  let(:advisee) { FactoryGirl.create(:advisee, user: user) }

  before do
    sign_in user
  end

  scenario 'User visits advisee details page and sees all notes' do
    notes = FactoryGirl.create_list(:note, 3, advisee: advisee)

    visit advisee_path(advisee)

    notes.each do |note|
      expect(page).to have_content(note.body)
    end
  end

  scenario 'Most recent notes are at the top of the list' do
    old_note = FactoryGirl.create(:note,
                                  advisee: advisee,
                                  updated_at: DateTime.new(2010, 2, 3, 4, 5))
    new_note = FactoryGirl.create(:note,
                                  advisee: advisee,
                                  updated_at: DateTime.new(2016, 7, 19, 8, 0))
    note = FactoryGirl.create(:note,
                              advisee: advisee,
                              updated_at: DateTime.new(2016, 7, 4, 8, 0))

    visit advisee_path(advisee)

    expect(new_note).to appear_before(note)
    expect(new_note).to appear_before(old_note)
    expect(note).to appear_before(old_note)
  end

  scenario 'There is a message if there are no notes for the advisee' do
    visit advisee_path(advisee)

    expect(page).to have_content('There are no notes for this advisee.')
  end
end
