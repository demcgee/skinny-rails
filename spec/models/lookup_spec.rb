require 'rails_helper'

RSpec.describe Lookup, type: :model do
  subject { create(:lookup) }

  it { expect(subject).to be_valid }

  it { should validate_presence_of(:slug) }
  it { should validate_presence_of(:ip_address) }
  it { should belong_to(:slug) }

  it "rejects invalid urls as referrers" do
    ["this-is-not-a-url",
     "notaformat://notaformat.com",
     1234,
     "user@example.com",
     "!$?"].each_with_index do |referrer, idx|
      lookup = build(:lookup, referrer: referrer)
      expect(lookup.valid?).to be_falsey
      expect(lookup.errors[:referrer]).not_to be_empty
      expect(lookup.errors[:referrer]).to include("is not a valid uri")
    end
  end

  it "rejects invalid ip addresses" do
    ["garbage",
     "1.2.3",
     "notaformat://notaformat.com",
     "user@example.com",
     "!$?",
     "1234"].each_with_index do |referrer, idx|
      lookup = build(:lookup, ip_address: referrer)

      expect(lookup.valid?).to be_falsey
      expect(lookup.errors[:ip_address]).not_to be_empty
      expect(lookup.errors[:ip_address]).to include("is not a valid ip address")
    end
  end

  # this tripped us up earlier: when testing #uniqueness, ActiveRecord
  # makes a callback to PG. this SELECT statement throws a PG exception,
  # so we should exclude 1234 from the 'invalid ip addresses' test,
  # above. 1234 is a number, inet is expecting a string
  it "raises PG error if referrer is not a string" do
    expect {
      build(:lookup, ip_address: 1234).valid? # triggers #uniqueness
    }.to raise_error(ActiveRecord::StatementInvalid)
  end
end
