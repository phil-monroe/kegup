require 'spec_helper'

describe Tap do

  it { should belong_to(:keg) }
  it { should belong_to(:org) }


  it 'must have a unique name for an org' do
    tap1 = build(:tap, org_id: 1, name: 'tap 1')
    expect(tap1).to be_valid
    tap1.save
    expect(build(:tap, org_id: 1, name: 'tap 1')).to_not be_valid
  end

  describe 'modifying kegs' do
    let(:keg1) { create(:keg) }
    let(:keg2) { create(:keg) }
    let(:tap){ create(:tap) }

    it 'updates new kegs tapped date' do
      expect(keg1.tapped_date).to be_nil
      expect(keg1.finished_date).to be_nil
      expect(keg2.tapped_date).to be_nil
      expect(keg2.finished_date).to be_nil

      tap.keg = keg1
      tap.save
      keg1.reload
      keg2.reload

      expect(keg1.tapped_date).to be_present
      expect(keg1.finished_date).to be_nil
      expect(keg2.tapped_date).to be_nil
      expect(keg2.finished_date).to be_nil

      tap.keg = keg2
      tap.save
      keg1.reload
      keg2.reload

      expect(keg1.tapped_date).to be_present
      expect(keg1.finished_date).to be_present
      expect(keg2.tapped_date).to be_present
      expect(keg2.finished_date).to be_nil

      tap.keg = nil
      tap.save
      keg1.reload
      keg2.reload

      expect(keg1.tapped_date).to be_present
      expect(keg1.finished_date).to be_present
      expect(keg2.tapped_date).to be_present
      expect(keg2.finished_date).to be_present
    end

  end

end
