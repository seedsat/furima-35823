crumb :root do
  link "Home", root_path
end

crumb :user_show do |user|
  link "#{user.nickname}さんのマイページ", user_path(user)
  parent :root
end

crumb :item_show do |item|
  link "#{item.name}", item_path(item)
  parent :root
end