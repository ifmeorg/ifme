json.array!(@medications) do |medication|
  json.extract! medication, :id, :name, :dosage, :refill
  json.url medication_url(medication, format: :json)
end
