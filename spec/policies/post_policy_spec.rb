require "rails_helper"

describe PostPolicy do
  let(:anon)    { nil }
  let(:user)    { create(:user) }
  let!(:author) { create(:user) }
  let(:admin)   { create(:user, admin: true) }
  let(:post)    { create(:post, user: author) }

  subject { PostPolicy }

  context 'for a visitor' do
    permissions :create?, :edit?, :update?, :destroy? do
      it { is_expected.to_not permit(anon, post) }
    end
  end

  context 'for a user' do
    permissions :create? do
      it { is_expected.to permit(user, post) }
    end
  end

  context 'for the author' do
    permissions :edit?, :update? do
      it { is_expected.to permit(author, post) }
    end
  end

  context 'for an admin' do
    permissions :create?, :destroy? do
      it { is_expected.to permit(admin, post) }
    end
  end
end
