RSpec.describe AddressBook do

  # before do
  #   book = AddressBook.new
  # end

  let(:book) { AddressBook.new }

  # helper methods
  def check_entry(entry, expected_name, expected_number, expected_email)
    expect(entry.name).to eql expected_name
    expect(entry.phone_number).to eql expected_number
    expect(entry.email).to eql expected_email
  end  

  context 'attributes' do
    it 'responds to entries' do
      expect(book).to respond_to(:entries)
    end

    it 'initializes entries as an array' do
      expect(book.entries).to be_a(Array)
    end

    it 'initializes entries as empty' do
      expect(book.entries.size).to eql(0)
    end
  end

  context '#add_entry' do
    before do
      book.add_entry('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')
    end

    it 'adds only one entry to address book' do
      expect(book.entries.size).to eql(1)
    end

    it 'adds the correct info to entries' do
      new_entry = book.entries[0]
      expect(new_entry.name).eql? 'Ada Lovelace'
      expect(new_entry.phone_number).eql? '010.012.1815'
      expect(new_entry.email).eql? 'augusta.king@lovelace.com'
    end
  end

  context '#remove_entry' do
    it "removes a specific entry" do
      book.remove_entry(book.entries[0])
      expect(book.entries.size).to eql(0)
    end
  end

  context '#import_from_csv' do
    it 'imports the correct number of entries' do
      book.import_from_csv('entries.csv')
      book_size = book.entries.size
      expect(book_size).to eql 5
    end

    it 'imports the first entry' do
      book.import_from_csv('entries.csv')
      first_entry = book.entries[0]

      check_entry(first_entry, 'Bill', '555-555-5555', 'bill@blocmail.com')
    end

    it "imports the 2nd entry" do
      book.import_from_csv("entries.csv")
      entry_two = book.entries[1]

      check_entry(entry_two, 'Bob', '555-555-5555', 'bob@blocmail.com')
    end

    it "imports the 3rd entry" do
      book.import_from_csv("entries.csv")
      entry_three = book.entries[2]

      check_entry(entry_three, 'Joe', '555-555-5555', 'joe@blocmail.com')
    end

    it 'imports from a second csv data source' do
      book.import_from_csv('entries2.csv')
      book_size = book.entries.size
      expect(book_size).to eql 3
    end
  end

end
