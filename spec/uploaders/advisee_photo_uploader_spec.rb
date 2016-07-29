require 'rails_helper'

describe 'AdviseePhotoUploader' do
  it 'sets the storage to fog if in development or production' do
    allow(Rails).to receive_message_chain(:env, :test?).and_return(false)
    expect(CarrierWave::Uploader::Base).to receive(:storage).with(:fog)
    uploader = AdviseePhotoUploader.new
  end
end
