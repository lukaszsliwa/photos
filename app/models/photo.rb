#
# Model zdjęć
#
# ALLOW_EXTENSIONS określa rozszerzenia plików jakie mogą być uploadowane.
#
# Każde zdjęcie ma swojego właściciela:
#
#   photo.user
#
# Każde zdjęcie może posiadać wiele komentarzy:
#
#   photo.comments
#
# Domyślnie zdjęcia są listowane w kolejności od najmłodszego do najstarszego.
# Jedynym akceptowalnym atrybutem w formularzu jest :file
#
# Wymagane pola: file, user
#
class Photo < ActiveRecord::Base

  ALLOW_EXTENSIONS = ['png', 'jpeg', 'jpg']

  belongs_to :user
  has_many :comments, :dependent => :destroy

  default_scope :order => 'created_at desc'

  attr_accessible :file

  mount_uploader :file, FileUploader

  validates_presence_of :file, :message => 'Please choose a file.'
  validates_presence_of :user, :message => 'We can\'t identify you as a user'

end
