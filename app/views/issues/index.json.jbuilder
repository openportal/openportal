json.array!(@issues) do |issue|
  json.extract! issue, :organization_id, :name, :url, :issue_id, :status, :level, :description
  json.url issue_url(issue, format: :json)
end
