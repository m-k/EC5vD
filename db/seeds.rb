JSON.parse(File.read('data/orders.json')).each do |order|
  order['state'].downcase!
  Order.create!(order.transform_keys(&:underscore))
end
