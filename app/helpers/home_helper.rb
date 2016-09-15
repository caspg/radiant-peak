module HomeHelper
  def prettify_analyzer_result(username, result)
    result[:errors].nil? ? result_message(username, result) : result[:errors]
  end

  def result_message(username, result)
    "#{username}'s favourite language is #{result[:favourite_language]}"
  end
end
