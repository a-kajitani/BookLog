# README

h3. モデル設計

h4. 1. User

* name, email, など
* has_many :books
* has_many :comments

h4. 2. Book

* title, author
* belongs_to :user
* has_many :sections

h4. 3. Section（章＋ページをまとめたもの）

* title, page_number, content
* belongs_to :book
* has_many :comments

h4. 4. Comment

* content
* belongs_to :user
* belongs_to :section

h3. 機能イメージ

* ユーザーが本を作成（題名・著者名）
* 本に章（Section）を追加（ページ番号や内容も含む）
* 各章に感想（コメント）を投稿
* ユーザーのページで投稿一覧を表示