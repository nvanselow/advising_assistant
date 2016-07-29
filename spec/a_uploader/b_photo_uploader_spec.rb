require 'rails_helper'

describe 'AdviseePhotoUploader' do
  it 'calls file for storage in test' do
    allow(Rails).to receive_message_chain(:env, :test?).and_return(true)
    expect(AdviseePhotoUploader).to receive(:storage).with(:file)
    load File.expand_path('./app/uploaders/advisee_photo_uploader.rb')
  end

  it 'calls fog for storage in production' do
    SimpleCov.start do
      command_name 'fog-test'
    end
    allow(Rails).to receive_message_chain(:env, :test?).and_return(false)
    expect(AdviseePhotoUploader).to receive(:storage).with(:fog)

    load File.expand_path('./app/uploaders/advisee_photo_uploader.rb')
  end

  it 'calls file for storage in test' do
    allow(Rails).to receive_message_chain(:env, :test?).and_return(true)
    expect(AdviseePhotoUploader).to receive(:storage).with(:file)
    load File.expand_path('./app/uploaders/advisee_photo_uploader.rb')
  end
end
