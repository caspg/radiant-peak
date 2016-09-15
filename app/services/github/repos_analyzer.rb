module Github
  class ReposAnalyzer
    HTTP_OK = '200'.freeze

    def initialize(username)
      @username = username
    end

    def find_favourite_language
      if user_repos_response.code == HTTP_OK
        { favourite_language: favourite_language, errors: nil  }
      else
        { favourite_language: nil, errors: user_repos_response.message }
      end
    end

    private

    attr_reader :username

    def user_repos_response
      @user_repos_response ||= Github::ApiWrapper.new(username).user_repos
    end

    def parsed_response_body
      JSON.parse(user_repos_response.body)
    end

    def repos_languages
      parsed_response_body.map { |repo| repo['language'] }
    end

    def favourite_language
      repos_languages.max_by do |lang|
        repos_languages.count(lang)
      end
    end
  end
end
