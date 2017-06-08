require "rails_helper"

describe ChatroomPolicy do
  let(:anon)      { nil }
  let(:user)      { create(:user) }
  let(:admin)     { create(:user, admin: true) }
  let!(:author)   { create(:user) }
  let!(:chatroom) { create(:chatroom, creator: author.username) }

  subject { ChatroomPolicy }

  context 'for a visitor' do
    permissions :index?, :create?, :edit?, :update?, :show?, :destroy? do
      it { is_expected.to_not permit(anon, chatroom) }
    end
  end

  context 'for a user' do
    permissions :index?, :create?, :show? do
      it { is_expected.to permit(user, chatroom) }
    end

    permissions :destroy?, :edit?, :update? do
      it { is_expected.to_not permit(user, chatroom) }
    end
  end

  context 'for an author' do
    permissions :edit?, :update? do
      it { is_expected.to permit(author, chatroom) }
    end
  end

  context 'for an admin' do
    permissions :index?, :create?, :edit?, :update?, :show?, :destroy? do
      it { is_expected.to permit(admin, chatroom) }
    end
  end
end
