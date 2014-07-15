Fabricator(:queue_item) do
  position { Fabricate.sequence }
end