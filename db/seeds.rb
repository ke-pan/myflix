# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


video1 = Video.create( name: "Family Guy", 
  description: "Video about family",
  cover_url: "/tmp/family_guy.jpg",
  video_url: "/tmp/monk_large.jpg"
  )
video2 = Video.create( name: "Futurama", 
  description: "Video about futurama",
  cover_url: "/tmp/futurama.jpg",
  video_url: "/tmp/monk_large.jpg"
  )
video3 = Video.create( name: "Monk", 
  description: "Video about monk",
  cover_url: "/tmp/monk.jpg",
  video_url: "/tmp/monk_large.jpg"
  )
video4 = Video.create( name: "South Park", 
  description: "Video about south park",
  cover_url: "/tmp/south_park.jpg",
  video_url: "/tmp/monk_large.jpg"
  )


cate_commedy = Category.create(name: "commedy")
cate_drama = Category.create(name: "drama")
cate_reality = Category.create(name: "reality")

cate_commedy.videos << video1 << video2
cate_drama.videos << video1 << video3
cate_reality.videos << video3 << video4
