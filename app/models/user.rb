class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image

  # Bookテーブルと1:Nの関係になるようアソシエーションを定義
  has_many :books, dependent: :destroy

  # モデル側でメソッドを定義しView側で呼び出しが可能なようにする
  def get_profile_image
    if profile_image.attached?
      profile_image
    else
      'no_image.jpg'
    end
  end
end


