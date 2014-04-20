json.array!(@alerts) do |alert|
  json.extract! alert, :id, :userid, :trigger, :medication, :message, :means, :days, :time
  json.url alert_url(alert, format: :json)
end
