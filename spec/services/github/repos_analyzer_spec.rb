require 'rails_helper'

describe Github::ReposAnalyzer do
  describe '#find_favourite_language' do
    subject { described_class.new('username') }

    let(:api_wrapper)  { double(:api_wrapper) }

    before do
      allow(Github::ApiWrapper).to receive(:new) { api_wrapper }
      allow(api_wrapper).to receive(:user_repos) { api_response }
    end

    context 'when https response is not 200' do
      let(:api_response)    { double(:api_response, code: '404', message: 'Not Found') }
      let(:expected_result) { { favourite_language: nil, errors: 'Not Found' } }

      it { expect(subject.find_favourite_language).to eq(expected_result) }
    end

    context 'when http response is 200' do
      let(:response_body) do
        [{ language: 'Ruby' }, { language: 'Ruby' }, { language: 'Javascript' }].to_json
      end

      let(:api_response)    { double(:api_response, code: '200', message: 'OK', body: response_body) }
      let(:expected_result) { { favourite_language: 'Ruby', errors: nil } }

      it { expect(subject.find_favourite_language).to eq(expected_result) }
    end
  end
end
