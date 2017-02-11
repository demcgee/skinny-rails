require 'rails_helper'

RSpec.describe Slug, type: :model do
  subject { build(:slug) }

  it { should validate_presence_of(:slug) }
  it { should validate_presence_of(:given_url) }
  it { should validate_uniqueness_of(:given_url) }
  it { should have_many(:lookups) }

  it { expect(subject).to be_valid }

  it "rejects invalid urls" do
    ["this-is-not-a-url",
     "notaformat://notaformat.com",
     1234,
     "user@example.com",
     "!$?"].each_with_index do |url, idx|
      slug = Slug.new(slug: "abcd#{idx}", given_url: url)
      expect(slug.valid?).to be_falsey
      expect(slug.errors[:given_url]).not_to be_empty
      expect(slug.errors[:given_url]).to include("is not a valid url")
    end
  end

  it "accepts valid urls" do
    ["http://google.com",
     "https://google.com",
     "http://garbage",
     URI.encode('https://user:password@my.secret.website.com:8888/this/is/a/path?with=a&bunch=of&get=params&some=spaces because i hate users')].each_with_index do |url, idx|
      slug = Slug.new(slug: "abcd#{idx}", given_url: url)
      expect(slug.valid?).to be_truthy
      expect(slug.errors[:given_url]).to be_empty
    end
  end


  # question: if a user submits user:password@someaddress.com, what
  # should we do?
  # 1) reject it (and provide a useful error message)
  # 2) strip out the user:password portion
  # 3) what would bit.ly do?

  it "doesn't orphan lookups when deleted" do
    slug = create(:slug)
    expect {
      slug.lookups.create(attributes_for(:lookup))
    }.to change{Lookup.count}.by(1)

    expect {
      slug.destroy!
    }.to change(Lookup, :count).by(-1)
  end
end
