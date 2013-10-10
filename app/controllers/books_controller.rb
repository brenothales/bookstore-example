class BooksController < ApplicationController
  def index
    if params[:query].present?
      @books = Book.search(params[:query], page: params[:page], per_page: 5)
    else
      @books = Book.all.page params[:page]
    end
  end

  def import
    book = Book.import params[:olid]
    notice = "Imported #{book.title}"
    redirect_to books_path, notice: notice
  rescue Book::ImportError
    redirect_to books_path, alert: "Failed to import book"
  end
end
