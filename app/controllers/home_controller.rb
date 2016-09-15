class HomeController < ApplicationController
  def index
    @analyzer_result = github_username.present? ? analyzer_result : nil
    @username = github_username
  end

  private

  def analyzer_result
    Github::ReposAnalyzer.new(github_username).find_favourite_language
  end

  def github_username
    params[:github_username]
  end
end
