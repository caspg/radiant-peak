module Github
  class ApiWrapper
    BASE_URI = 'https://api.github.com'.freeze
    HTTP_OK = '200'.freeze

    def initialize(username)
      @username = username
    end

    def user_repos
      response = Net::HTTP.get_response(api_user_repos_uri)
    end

    private

    attr_reader :username

    def api_user_repos_uri
      URI(BASE_URI + "/users/#{username}/repos")
    end
  end
end
