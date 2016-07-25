user = User.where(email: 'nick+advising@nickvanselow.com').first

if(!user)
  user = User.create!(
    email: 'nick+advising@mailinator.com',
    password: 'password',
    password_confirmation: 'password',
    first_name: 'Nick',
    last_name: 'Test User'
  )
end

20.times do |num|
  Advisee.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: "advisee_#{num}@mailinator.com",
    graduation_semester: ['Fall', 'Spring', 'Summer'].sample,
    graduation_year: rand(2015..2020),
    user: user
  )
end

puts "Seed complete!"
