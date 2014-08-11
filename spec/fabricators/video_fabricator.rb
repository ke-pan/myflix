Fabricator(:video) do
  name { Faker::Name.name }
  description "it is an aweson video!"
  # reviews(count: 2)
end
