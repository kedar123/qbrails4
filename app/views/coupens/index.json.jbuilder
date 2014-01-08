json.array!(@coupens) do |coupen|
  json.extract! coupen, :id, :coupen
  json.url coupen_url(coupen, format: :json)
end
