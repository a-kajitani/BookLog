
crumb :root do
  link "ホーム", root_path
end
# ルート（本一覧）
crumb :book_list do
  link "書籍一覧", root_path  # ← root_path が books#index を指す
end

# 本の詳細
crumb :book_from_user do |payload| 
  book, user = payload.is_a?(Array) ? payload : [payload, nil]
  link (book.title.presence || "本詳細"), book_path(book)
  if user.present?
    parent :user, user
  else
    parent :book_list # ユーザーが取れなかった場合は一覧などにフォールバック
  end
end


crumb :book_from_default do |book|
  link book.title, book_path(book)
  parent :book_list
end


# 章一覧（その本の中）
crumb :book_sections do |book|
  link "章・ページ一覧", book_path(book)  # /books/:book_id/sections を想定
  parent :book_from_default, book
end

# 章の詳細
crumb :section do |section|
  # 章名の項目に合わせて content → name 等に変更可。長文なら truncate も検討
  link section.content, book_section_path(section.book, section)
  parent :book_sections, section.book
end

# 章の感想一覧
crumb :section_impression do |section|
  link "感想一覧",  book_section_path(section.book, section)
  parent :section, section
end

# # 感想の詳細
# crumb :impression do |impression|
#   link "感想: #{impression.id}", book_section_impression_path(impression.section.book, impression.section, impression)
#   parent :section_impression, impression.section
# end


# 本の追加（new）
crumb :book_new do
  link "書籍登録", new_book_path
  parent :root
end

# 章の追加（new）— どの本の中かが必要
crumb :section_new do |book|
  link "章・ページ追加", new_book_section_path(book)
  parent :book_sections, book
end

# 感想の追加（new）— 親は章詳細
crumb :impression_new do |section|
  link "感想投稿", new_book_section_impression_path(section.book, section)
  parent :section, section
end



# 本の編集（edit）
crumb :book_edit do |book|
  link "書籍情報編集", edit_book_path(book)
  parent :book_from_default, book
end


# 章の編集（edit）
crumb :section_edit do |section|
  link "章を編集", edit_book_section_path(section.book, section)
  parent :section, section
end


 #セクションからの感想の編集（edit）
crumb :impression_edit_from_section do |impression|
  link "感想編集", edit_book_section_impression_path(impression.section.book, impression.section, impression)
  parent :section_impression, impression.section
end

# ユーザーページ文脈からの感想編集
crumb :impression_edit_from_user do |impression|
  link "感想編集", edit_book_section_impression_path(impression.section.book, impression.section, impression)
  parent :user, impression.user
end
# Devise の registrations#edit を想定し、edit_user_registration_path を利用


crumb :user_settings do
  link "ユーザー設定", edit_user_registration_path
  parent :root
end


# ユーザー一覧
crumb :users do
  link "ユーザー一覧", users_path
  parent :root
end

# ユーザー詳細（任意：詳細ページがある場合）
crumb :user do |user|
  link "#{user.name}", user_path(user)
  parent :users
end
