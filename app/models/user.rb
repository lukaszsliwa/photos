#
# Model użytkowników
#
# Korzysta z gem'u devise
#
# Każdy użytkownika może mieć wiele zdjęć:
# => User.first
# => user.photos
#
class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_many :photos, :dependent => :destroy

  # Metoda zwraca true/false w zależności od tego, czy dany użytkownik
  # jest właścicielem wskazanego w parametrze obiektu
  #
  # => user = User.first
  # => photo = Photo.first
  # => user.owner?(photo)
  # False
  #
  def owner?(object)
    object.respond_to?(:user_id) && object.user_id == id
  end
  
end
