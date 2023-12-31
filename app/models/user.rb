class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image
  # Bookテーブルと1:Nの関係になるようアソシエーションを定義
  has_many :books, dependent: :destroy

  # バリデーションの設定
  validates :name, uniqueness: true
  validates :name, length: { in: 2..20 }
  validates :introduction,    length: { maximum: 50 }

  # モデル側でメソッドを定義しView側で呼び出しが可能なようにする
  def get_profile_image(width,height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      profile_image.variant(resize_to_limit: [width, height]).processed
  end
end


