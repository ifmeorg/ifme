json.array!(@allies) do |ally|
  json.extract! ally, :id, :userid, :allies
  json.url ally_url(ally, format: :json)
end
