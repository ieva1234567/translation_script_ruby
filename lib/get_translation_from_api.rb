# frozen_string_literal: true

class GetTranslationFromApi
  ENDPOINT = 'https://api.mymemory.translated.net/get'

  attr_reader :text_to_translate, :langpair

  def initialize(text_to_translate: '', langpair: 'lt|en')
    @text_to_translate = text_to_translate
    @langpair = langpair
  end

  def process
    parse_response(return_response)
  end

  def parse_response(return_response)
    return_response['responseData']['translatedText']
  end

  def return_response
    GetTextFromApi.new(api_url: 'https://api.mymemory.translated.net/get',
                       params: { q: text_to_translate, langpair: langpair },
                       more_than_one_page: false).process
  end
end
