require 'rails_helper'

describe Github::ApiWrapper do
  subject { described_class.new(username) }

  describe '#user_repos' do
    let(:username) { 'username' }
    let(:response) { double(:response, body: "[\"response body\"]") }

    before do
      allow(Net::HTTP).to receive(:get_response) { response }
      allow(JSON).to receive(:parse)
    end

    it 'makes a request and then parse response' do
      expected_uri = URI("https://api.github.com/users/#{username}/repos")

      subject.user_repos

      expect(Net::HTTP).to have_received(:get_response).with(expected_uri)
      expect(JSON).to have_received(:parse).with(response.body)
    end
  end
end
