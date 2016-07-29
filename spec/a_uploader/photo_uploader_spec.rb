fork{
  require 'spec_helper'

  describe 'AdviseePhotoUploader' do
    it 'calls fog for storage in production' do
      foo = Class.new do
        def self.env
        end

        def self.storage(_type)
        end
      end
      stub_const('Rails', foo)
      stub_const('CarrierWave', foo)
      stub_const('CarrierWave::Uploader::Base', foo)
      stub_const('Rails::Uploader', foo)
      stub_const('Rails::Base', foo)
      allow(Rails).to receive_message_chain(:env, :test?).and_return(false)
      require_relative '../../app/uploaders/advisee_photo_uploader'
    end
  end  
}
