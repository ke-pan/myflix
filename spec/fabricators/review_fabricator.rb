Fabricator(:review) do
  video
  user
  rate { (1..5).to_a.sample }
  description "cool video!"
end