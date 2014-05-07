class RecordController < ApplicationController
  def find_by
    @book = Book.find_by(publish: '技術評論社')
    render 'books/show'
  end

  def find_by2
    @book = Book.find_by(publish: '技術評論社', price: 2919)
    render 'books/show'
  end

  def where
    @books = Book.where(publish: '技術評論社')
    render 'hello/list'
  end

  def ph1
    @books = Book.where('publish = ? AND price >= ?', params[:publish], params[:price])
    render 'hello/list'
  end

  def not
    @books = Book.where.not(isbn: params[:id])
    render 'books/index'
  end

  def order
    @books = Book.where(publish: '技術評論社').order(published: :asc)
    render 'hello/list'
  end

  #def select
  #  @books = Book.where('price >= 2000').select(:title, :price)
  #  render 'hello/list'
  #end
  
  def select2
    @pubs = Book.select(:publish).distinct.order(:publish)
  end

  def groupby
    @books = Book.select('publish, AVG(price) AS avg_price').group(:publish)
  end

  def havingby
    @books = Book.select('publish, AVG(price) AS avg_price').group(:publish).having('AVG(price) >= ?', 2500)
    render 'record/groupby'
  end

  def update_all
    cnt = Book.where(publish: 'Gihyo').update_all(publish: '技術評論社')
    render text: "#{cnt}件のデータを更新しました。"
  end

  # 空のオブジェクトにupdateするとinsertされる
  #def update
  #  cnt = Book.new.update(published: '2014-05-07')
  #  render text: "#{cnt}件のデータを更新しました。"
  #end
end
