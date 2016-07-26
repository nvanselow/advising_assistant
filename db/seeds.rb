user = User.where(email: 'advisor@mailinator.com').first

if(!user)
  user = User.create!(
    email: 'advisor@mailinator.com',
    password: 'password',
    password_confirmation: 'password',
    first_name: 'Nick',
    last_name: 'Test User'
  )
end

puts "seeded user: advisor@mailinator.com"

18.times do |num|
  first_name = Faker::Name.first_name
  email = Faker::Internet.safe_email(first_name)

  Advisee.create!(
    first_name: first_name,
    last_name: Faker::Name.last_name,
    email: email,
    graduation_semester: ['Fall', 'Spring', 'Summer'].sample,
    graduation_year: rand(2017..2020),
    photo: File.open("#{Rails.root}/db/seed_photos/#{num}.png"),
    user: user
  )
end

puts "Seeded advisees"

advisees = Advisee.all

advisees.each do |advisee|

  advisee.notes.create!(body: 'Check with the registrar about app to graduate.')
  advisee.notes.create!(body: 'Great job in that class!')
  advisee.notes.create!(body: 'The ACE can help you navigate that system. '\
                              "Please contact #{Faker::Name.name}")
  advisee.notes.create!(body: "Take PSY #{rand(100..499)} next semester.")

  rand(0..3).times do
    start_time = Faker::Date.forward(15)
    end_time = start_time + 20.minutes
    meeting = advisee.meetings.create!(
      description: "Let's meet to discuss #{Faker::Superhero.power}",
      start_time: start_time,
      end_time: end_time,
      user: user
    )

    rand(0..5).times do
      meeting.notes.create!(body: "We discussed adding #{Faker::Superhero.power}")
    end
  end
end

puts "Seed complete!"
