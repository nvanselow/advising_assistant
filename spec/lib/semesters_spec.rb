require 'rails_helper'

describe Semesters do
  describe '.all' do
    it 'returns an array of all available semesters' do
      expect(Semesters.all).to eq(%w(Fall Spring Summer Winter))
    end
  end

  describe '.all_for_select' do
    it 'returns an array formatted for use in a select on a form' do
      expect(Semesters.all_for_select).to eq([
        %w(Fall Fall),
        %w(Spring Spring),
        %w(Summer Summer),
        %w(Winter Winter),
      ])
    end
  end
end
