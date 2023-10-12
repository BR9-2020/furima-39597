class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :items
  has_many :purchases
  
  validates :nickname, presence: true
  validates :last_name, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥々ー]/ }
  validates :first_name, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥々ー]/ }
  with_options presence: true, format: { with: /\A[ァ-ヶー]+\z/, message: '全角文字を使用してください' } do
    validates :last_name_kana
    validates :first_name_kana
  end
  validates :birth_date, presence: true
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i
  validates_format_of :password, with: PASSWORD_REGEX, message: 'には英字と数字の両方を含めて設定してください'
end
