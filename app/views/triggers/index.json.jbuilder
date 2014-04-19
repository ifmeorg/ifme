json.array!(@triggers) do |trigger|
  json.extract! trigger, :id, :category, :name, :mood, :why, :fix
  json.url trigger_url(trigger, format: :json)
end
