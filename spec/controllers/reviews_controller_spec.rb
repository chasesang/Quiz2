require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:idea) {FactoryGirl.create(:idea)}
  let(:review) { FactoryGirl.create(:review, {user: user, idea: idea})}

  describe '#create' do
    context 'with no user signed in' do
      it 'redirect the user to the sign in page' do
        post :create, params: {
          idea_id: idea.id,
          eview: FactoryGirl.attributes_for(:review),
          }
          expect(response).to redirect_to(new_session_path)
      end
    end

    context 'with user signed in' do
      before do
        request.session[:user_id] = user.id
      end
      def valid_request
        post :create, params: {
          idea_id: idea.id,
          review: FactoryGirl.attributes_for(:review),
          }
      end

      it 'creates a new review in the database'do

        count_before = Review.count
        valid_request
        count_after = Review.count
        expect(count_after).to eq(count_before + 1)
      end

      it 'redirect to the review show page' do
        valid_request
        expect(response).to redirect_to idea_path(idea)
      end

      it 'associates the created review with the signed in user' do
        valid_request
        expect(Review.last.user).to eq(user)
      end
    end
  end
end
