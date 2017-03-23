
#タイトル
json.title @title

#メニュー
json.ingredients do |json|
    json.array!(@ingredients) do |product|
      json.extract! product, :name, :amount
    end
end
