RSpec.describe AddressBook do

  before do
    @book = AddressBook.new
  end

  context 'attributes' do
    it 'responds to entries' do
      expect(@book).to respond_to(:entries)
    end

    it 'initializes entries as an array' do
      expect(@book.entries).to be_a(Array)
    end

    it 'initializes entries as empty' do
      expect(@book.entries.size).to eql(0)
    end
  end

end
