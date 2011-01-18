#
# Model komentarzy
#
# Komentarz posiada klucz obcy do zdjęcia, którego dotoczy.
# Akceptowane są tylko pola :author i :content.
#
# Wymagane pola: author, content, photo
#
#
class Comment < ActiveRecord::Base
  belongs_to :photo

  attr_accessible :author, :content

  validates_presence_of :author, :message => 'Author field is empty.'
  validates_presence_of :content, :message => 'Comment content is empty.'
  validates_presence_of :photo, :message => 'Choose a right photo.'

  # Metoda zwraca treść komentarza
  #
  # => c = Comment.new(:content => 'Test')
  # => puts c
  # Test
  #
  def to_s
    content
  end
end
