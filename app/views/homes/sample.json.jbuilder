json.title @title
json.array!(@ingredients) do |bus|
  json.extract! bus, :name, :amount
end
