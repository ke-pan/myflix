Fabricator(:video) do
  name { Faker::Name.name }
  description "it is an aweson video!"
  cover_url { Faker::Internet.url }
  video_url { Faker::Internet.url }
  # reviews(count: 2)
end