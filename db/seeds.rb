# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


video = Video.create( name: "Transformers: Age of Extinction (2014)", 
  description: "An automobile mechanic and his daughter make a discovery that brings down the Autobots - and a paranoid government official - on them.",
  cover_url: "/tmp/transformer4.jpg",
  video_url: "/tmp/transformer4_large.jpg"
  )


video.categories << Category.create(name: "commedy")
video.categories << Category.create(name: "drama")
video.categories << Category.create(name: "reality")


