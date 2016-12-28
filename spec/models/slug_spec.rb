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
     "http://garbage",
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

  it "doesn't orphan lookups when deleted" do
    slug = create(:slug)
    expect {
      slug.lookups.create(attributes_for(:lookup))
    }.to change(Lookups.count).by(1)

    expect {
      slug.destroy!
    }.to change(Lookups.count).by(-1)
  end
end
