# frozen_string_literal: true

class GetTextFromApi
  attr_accessor :api_url, :more_than_one_page, :params, :result_key

  def initialize(api_url: '', params: {}, more_than_one_page: false, result_key: '')
    @api_url = api_url
    @params = params
    @more_than_one_page = more_than_one_page
    @result_key = result_key
  end

  def process
    if more_than_one_page
      return_response_for_more_than_one_page(url: api_url)
    else
      return_response(url: api_url, params: params)
    end
  end

  def return_response_for_more_than_one_page
    final_response = []
    response = []
    page = 1
    until response.nil?
      params[:page] = page
      response = return_response(url: api_url, params: params)
      final_response += response
      page += 1
    end
  end

  def return_response(url: '', params: {})
    uri = URI.parse(url)
    uri.query = URI.encode_www_form(params)
    res = JSON.parse(Net::HTTP.get_response(uri).body)
    res = res[result_key] if result_key.present?
    res
  end
end
