module Web::Controllers::Books
  class Index
    include Web::Action

    expose :books

    def call(params)
      repo = BookRepository.new
      @books = repo.all
    end
  end
end
