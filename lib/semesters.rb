class Semesters
  SEMESTERS = %w(Fall Spring Summer Winter).freeze

  def self.all
    SEMESTERS
  end

  def self.all_for_select
    SEMESTERS.map do |semester|
      [semester, semester]
    end
  end
end
