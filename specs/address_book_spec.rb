require_relative '../models/address_book'

RSpec.describe AddressBook do

  let(:book) { AddressBook.new(store: 'test.pstore') }

  before do
    book.destroy_all
  end

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
      expect(book.entries).to be_an_instance_of(PStore)
    end

    it 'initializes entries as empty' do
      expect(book.entry_count).to eql(0)
    end
  end

  context '#create' do
    before do
      book.create('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')
    end

    it 'adds only one entry to address book' do
      expect(book.entry_count).to eql(1)
    end

    it 'adds the correct info to entries' do
      new_entry = book.find('augusta.king@lovelace.com')
      expect(new_entry.name).eql? 'Ada Lovelace'
      expect(new_entry.phone_number).eql? '010.012.1815'
      expect(new_entry.email).eql? 'augusta.king@lovelace.com'
    end
  end

  context '#destroy' do
    it "removes a specific entry" do
      entry = book.find('augusta.king@lovelace.com')
      book.destroy(entry)
      expect(book.entry_count).to eql(0)
    end
  end

  context '#import_from_csv' do
    it 'imports the correct number of entries' do
      book.import_from_csv('entries.csv')
      book_size = book.entry_count
      expect(book_size).to eql 5
    end

    it 'imports the first entry' do
      book.import_from_csv('entries.csv')
      entry_one = book.find('bill@blocmail.com')

      check_entry(entry_one, 'Bill', '555-555-5555', 'bill@blocmail.com')
    end

    it "imports the 2nd entry" do
      book.import_from_csv("entries.csv")
      entry_two = book.find('bob@blocmail.com')

      check_entry(entry_two, 'Bob', '555-555-5555', 'bob@blocmail.com')
    end

    it "imports the 3rd entry" do
      book.import_from_csv("entries.csv")
      entry_three = book.find('joe@blocmail.com')

      check_entry(entry_three, 'Joe', '555-555-5555', 'joe@blocmail.com')
    end

    it 'imports from a second csv data source' do
      book.import_from_csv('entries2.csv')
      book_size = book.entry_count
      expect(book_size).to eql 3
    end
  end

  context '#find' do
    it 'searches for a non-existent entry' do
      book.import_from_csv('entries.csv')
      entry = book.find('guy@glocmail.com')
      expect(entry).to eql('No records found')
    end

    it 'searches for an existent entry' do
      book.import_from_csv('entries.csv')
      entry = book.find('bob@blocmail.com')
      expect(entry.instance_of?(Entry))
      check_entry(entry, 'Bob', '555-555-5555', 'bob@blocmail.com')
    end

    it 'searches for an entry that appears suspiciously similar to an existant entry' do
      book.import_from_csv('entries.csv')
      result = book.find('Bobb')
      expect(result).to eql('No records found')
    end
  end

end
