class CommentsController < ApplicationController
  before_filter :get_photo

  # GET
  # Tworzy formularz komentowania z pustym komentarzem
  def new
    @comment = Comment.new
  end

  # POST
  # Tworzy nowy komentarz. Jeśli komentarz jest poprawny to zapisuje go i przekierowuje na stronę ze zdjęciem
  # Jeśli komentarz nie jest poprawny, tworzy stronę z formularzem i błędami.
  def create
    @comment = @photo.comments.new(params[:comment])

    respond_to do |format|
      if @comment.save
        format.html { redirect_to(photo_url(@photo, :anchor => "comment-#{@comment.to_param}"), :notice => 'Comment was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  private

  # Pobiera rekord z bazy na podstawie :photo_id
  def get_photo
    @photo = Photo.find(params[:photo_id])
  end

end
