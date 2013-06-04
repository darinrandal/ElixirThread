json.array!(@ratings) do |rating|
  json.extract! rating, :post_id, :user_id, :event_type
  json.url rating_url(rating, format: :json)
end