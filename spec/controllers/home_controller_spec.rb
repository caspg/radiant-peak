require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end

    context 'when there is github_username param present' do
      let(:username) { 'username' }
      let(:analyzer) { double }

      before do
        allow(Github::ReposAnalyzer).to receive(:new) { analyzer }
        allow(analyzer).to receive(:find_favourite_language)
      end

      it 'calls Github::ReposAnalyzer' do
        get :index, github_username: username

        expect(Github::ReposAnalyzer).to have_received(:new).with(username)
        expect(analyzer).to have_received(:find_favourite_language)
      end
    end
  end
end
