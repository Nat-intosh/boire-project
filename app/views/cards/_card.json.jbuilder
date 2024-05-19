json.extract! card, :id, :card_type, :desc, :title, :group, :created_at, :updated_at
json.url card_url(card, format: :json)
