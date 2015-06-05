RSpec.describe Entry do

  before do
    @entry = Entry.new('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')
  end

  context 'attributes' do

    it 'responds to name' do
      expect(@entry).to respond_to(:name)
    end

    it 'responds to phone number' do
      expect(@entry).to respond_to(:phone_number)
    end

    it 'responds to email' do
      expect(@entry).to respond_to(:email)
    end
  end

  context '#to_s' do
    it 'prints an entry as a string' do
      expected_string = "Name: Ada Lovelace\nPhone Number: 010.012.1815\nEmail: augusta.king@lovelace.com"
      expect(@entry.to_s).to eq(expected_string)
    end
  end

end
