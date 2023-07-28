class Book < ApplicationRecord
  # userテーブルと1:Nの関係になるようアソシエーションを定義
  belong_to :user
end
