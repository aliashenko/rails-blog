require 'rails_helper'

describe User do
  it { should have_many(:posts).dependent(:destroy) }

  let(:user) { FactoryGirl.create(:user) }

  describe '#assign_role' do
    before(:each) { user.save }

    context 'when role is previously assigned' do
      before(:each) { user.role = 'Admin' }

      it { expect(user.role).to eq('Admin') }
      it { expect(user.role).not_to be_nil }
    end

    context 'when role is nil' do

      it { expect(user.role).to eq('Regular') }
      it { expect(user.role).not_to be_nil }
    end
  end

  describe '#admin?' do
    subject { user.admin? }

    context 'when user is admin' do
      before(:each) { user.role = 'Admin' }

      it { is_expected.to be_truthy }
      it { is_expected.not_to be_nil }
    end

    context 'when user is regular' do
      before(:each) { user.role = 'Regular' }

      it { is_expected.to be_falsey }
      it { is_expected.not_to be_nil }
    end
  end
end
