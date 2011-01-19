# Kontroler zdjęć
#
# Umożliwia dodawanie, listowanie i podgląd zdjęcia (zdjęć).
# Aby zablokować możliwość usuwania zdjęć przez osoby, które nie są ich właścicielami
# metody są wywoływane dla danego użytkownika np.:
#
#   current_user.photos.find(14)
#
# Takie rozwiązanie zapewnia, że jeśli użytkownik nie dodał danego zdjęcia od ID=14
# zostanie zwrócony wyjątek RecordNotFound a w efekcie zobaczy stronę błędu 404.
#
# Przy uploadowaniu wielu plików wykorzystywany jest iframe i ładowanie strony
# do uploadu pojedynczego pliku (odpowiednio dostosowanej - z ustawionym :layout => false).
#
# Przed wywołaniem każdej akcji (poza :index i :show) sprawdzane jest, czy użytkownik jest zalogowany.
# Jeśli nie jest zalogowany to jest przenoszony na stronę logowania.
#
class PhotosController < ApplicationController

  before_filter :authenticate_user!, :except => [:index, :show]

  # GET
  # Listuje miniatury dzieląc je na strony po 9 na każdej.
  # Zdjęcie są listowane w kolejności od najmłodszego do najstarszego.
  def index
    @photos = Photo.all.paginate :page => params[:page], :per_page => 9

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET
  # Strona dla dużego zdjęcia.
  def show
    @photo = Photo.find(params[:id])
    @comment = @photo.comments.new
    @comments = @photo.comments

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET
  # Tworzy strone z możliwością ładowania wielu zdjęć. Utworzona strona ładuje w iframe
  # adres /photos/new z możliwością dodawania nowych formularzy co odbywa się przez klonowanie
  # odpowiedniego bloku z załadowanym iframe.
  # Przyciskają 'Upload files' w JavaScripcie wywołuje form w każdym z utworzonych iframe sprawiając wrażenie
  # asynchronicznego uploadu plików.
  def upload
  end

  # Tworzy formularz do dodawanie pojedynczego zdjecia
  def new
    @photo = Photo.new

    respond_to do |format|
      format.html { render :layout => params[:layout] }# new.html.erb
    end
  end

  # Tworzy nowe zdjęcie i zapisuje do bazy w zależności od tego,
  # czy formularz jest poprawnie wypełniony.
  def create
    @photo = current_user.photos.new(params[:photo])

    respond_to do |format|
      if @photo.save
        format.html { render :template => 'photos/done', :layout => false }
      else
        format.html { render :action => "new", :layout => false }
      end
    end

  end

  # Usuwa zdjęcie. Usuwać może tylko ten użytkownik, który je dodał.
  def destroy
    @photo = current_user.photos.find(params[:id])
    @photo.destroy

    respond_to do |format|
      format.html { redirect_to(photos_url) }
    end
  end

end
