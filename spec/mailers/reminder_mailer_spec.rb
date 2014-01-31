require "spec_helper"



describe OrgMailer do

  let(:mailer) { OrgMailer }
  let(:org){ FactoryGirl.create :org }

  describe '#tap_empty_email' do
    before do
      @email = OrgMailer.tap_empty_email(org).deliver
    end

    it 'should send a single email' do
      ActionMailer::Base.deliveries.count.should eq 1
    end
    it 'should send email to the org reminder email address' do
      ActionMailer::Base.deliveries.any? { |email| email.to.first.to_s.eql? org.reminder_email }.should be_true
    end
    context 'delivery' do
      subject(:delivery) { ActionMailer::Base.deliveries.first }
      its(:from)     { should eq ['notification@kegup.com'] }
      its(:to)       { should eq [org.reminder_email] }
      its(:subject)  { should eq 'BEER TAP EMPTY!!!' }
    end

  end

  describe '#tap_empty_email no email address' do
    before do
      @email = OrgMailer.tap_empty_email(build(:org, reminder_email: nil)).deliver
    end

    it 'should not send a single email' do
      ActionMailer::Base.deliveries.count.should eq 0
    end

  end

end

