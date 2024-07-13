# frozen_string_literal: true

class GetTranslationFromApi
  ENDPOINT = 'https://api.mymemory.translated.net/get'
  REMOVE_SYMBOLS = /[!@#$%^&*()_+{}\[\]:;'"\/\\?><.,]/

  attr_reader :text_to_translate, :langpair

  def initialize(text_to_translate: '', langpair: 'lt|en')
    @text_to_translate = text_to_translate
    @langpair = langpair
  end

  def process
    #binding.pry if text_to_translate.include?('"')
    if (text_to_translate =~ REMOVE_SYMBOLS).nil?
      parse_response(return_response(text_to_translate))
    else
      translate_leaving_symbols(text_to_translate)
    end
  end

  def translate_leaving_symbols(text_to_translate)
    txt = text_to_translate
    return_str = ''
    until (txt =~ REMOVE_SYMBOLS).nil?
      return_array = translate_parts(txt, return_str)
      txt = return_array[0]
      return_str = return_array[1]
    end
    return_str += parse_response(return_response(txt))
    return_str
  end

  def translate_parts(txt, return_str)
    ind = (txt =~ REMOVE_SYMBOLS)
    # get html and translate text part somewhere here GetHtmlAndTextPart
    return_str += parse_response(return_response(txt[0..ind - 1])).gsub(REMOVE_SYMBOLS, '') + txt[ind]
    [txt = txt[ind + 1..], return_str]
  end

  def parse_response(return_response)
    return_response['responseData']['translatedText']
  end

  def return_response(txt)
    GetTextFromApi.new(api_url: 'https://api.mymemory.translated.net/get',
                       params: { q: txt, langpair: langpair },
                       more_than_one_page: false).process
  end
end
