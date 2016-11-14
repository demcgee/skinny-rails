require 'rails_helper'

RSpec.describe Lookup, type: :model do
  subject { create(:lookup) }

  it { expect(subject).to be_valid }

  it { should validate_presence_of(:slug) }
  it { should validate_presence_of(:ip_address) }
  it { should belong_to(:slug) }

  it "rejects invalid urls as referrers" do
    ["this-is-not-a-url",
     "http://garbage",
     "notaformat://notaformat.com",
     1234,
     "user@example.com",
     "!$?"].each_with_index do |referrer, idx|
      lookup = build(:lookup, referrer: referrer)

      expect { lookup.valid? }.to be_falsey
      expect { lookup.errors[:referrer] }.not_to be_empty
      expect { lookup.errors[:referrer] }.to include("is not a valid uri")
    end
  end

  it "rejects invalid ip addresses" do
    ["garbage",
     "1.2.3",
     "notaformat://notaformat.com",
     1234,
     "user@example.com",
     "!$?"].each_with_index do |referrer, idx|
      lookup = build(:lookup, ip_address: referrer)

      expect { lookup.valid? }.to be_falsey
      expect { lookup.errors[:ip_address] }.not_to be_empty
      expect { lookup.errors[:ip_address] }.to include("is not a valid ip address")
    end
  end
end
