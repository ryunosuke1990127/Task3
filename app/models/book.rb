class Book < ApplicationRecord
 # userテーブルと1:Nの関係になるようアソシエーションを定義
  belongs_to :user

  # バリデーションの設定
  validates :title, presence: true
  validates :body, presence: true

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end
end
