require 'spec_helper'

describe User do
  it { should have_many(:posts).dependent(:destroy) }
  it { should belong_to(:role) }

  describe '#assign_role' do
    before(:each) { user.save }

    context 'when role is previously assigned' do
      let(:role) { FactoryGirl.create(:role, name: 'Admin') }
      let(:user) { FactoryGirl.create(:user, role: role) }

      it { expect(user.role.name).to eq('Admin') }
      it { expect(user.role.name).not_to eq('Regular') }
      it { expect(user.role).not_to be_nil }
    end

    context 'when role is nil' do
      let(:role) { FactoryGirl.create(:role, name: 'Regular') }
      let(:user) { FactoryGirl.create(:user) }

      it { expect(user.role.name).to eq('Regular') }
      it { expect(user.role.name).not_to eq('Admin') }
      it { expect(user.role).not_to be_nil }
    end
  end

  describe '#admin?' do
    let(:user) { FactoryGirl.create(:user, role: role) }
    
    subject { user.admin? }

    context 'when user is admin' do
      let(:role) { FactoryGirl.create(:role, name: 'Admin') }

      it { is_expected.to be_truthy }
      it { is_expected.not_to be_nil }
    end

    context 'when user is regular' do
      let(:role) { FactoryGirl.create(:role, name: 'Regular') }

      it { is_expected.to be_falsey }
      it { is_expected.not_to be_nil }
    end
  end
end
