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

  context '#add_entry' do
    before do
      @book.add_entry('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')
    end

    it 'adds only one entry to address book' do
      expect(@book.entries.size).to eql(1)
    end

    it 'adds the correct info to entries' do
      new_entry = @book.entries[0]
      expect(new_entry.name).eql? 'Ada Lovelace'
      expect(new_entry.phone_number).eql? '010.012.1815'
      expect(new_entry.email).eql? 'augusta.king@lovelace.com'
    end
  end

  context '#remove_entry' do
    it "removes a specific entry by email" do
      @book.remove_entry('augusta.king@lovelace.com')
      expect(@book.entries.size).to eql(0)
    end

  end

end
