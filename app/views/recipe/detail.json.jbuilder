json.title @title
json.ingredients do |json|
  json.array!(@ingredients) do |product|
    json.extract! product, :name, :amount
  end
end
