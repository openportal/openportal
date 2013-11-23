json.array!(@organizations) do |organization|
  json.extract! organization, :name, :description, :photo_url
  json.url organization_url(organization, format: :json)
end
