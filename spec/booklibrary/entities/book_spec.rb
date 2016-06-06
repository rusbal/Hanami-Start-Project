require 'spec_helper'

RSpec.describe Book do
  it 'can be initilised with attributes' do
    book = Book.new(title: 'Refactoring')
    expect(book.title).to eq 'Refactoring'
  end
end
