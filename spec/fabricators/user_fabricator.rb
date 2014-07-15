Fabricator(:user) do
  name { Faker::Name.name }
  email { Faker::Internet.email }
  password { Faker::Internet.password }
  # reviews(count: 2)
end