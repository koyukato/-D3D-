#タイトル
json.Title @title
#所要時間
json.Time @incTime
#価格
json.Money @incMoney
#工程数
json.Step @step
#メニュー
json.Ingredients do |json|
    json.array!(@ingredients) do |product|
      json.extract! product, :Name, :Amount
    end
end
