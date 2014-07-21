Fabricator(:queue_item) do
  position { Fabricate.sequence }
  video
end