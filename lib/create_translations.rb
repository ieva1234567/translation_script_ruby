# frozen_string_literal: true

# fills desired language file from primary language and fills both from given endpoint
class CreateTranslations
  attr_reader :api_url, :params, :more_than_one_page, :result_key, :trans_keys, :lng, :files

  def initialize(class_params: { api_url: '', params: {}, more_than_one_page: false, result_key: '',
                                 trans_keys: [], lng: {}, files: {} })
    @api_url = class_params[:api_url]
    @params = class_params[:params]
    @more_than_one_page = class_params[:more_than_one_page]
    @result_key = class_params[:result_key]
    @trans_keys = class_params[:trans_keys]
    @lng = class_params[:lng]
    @files = class_params[:files]
  end

  def process
    AddKeysToMainFile.new(trans_keys: trans_keys, lng: lng,
                          trans_arr: return_data_for_translation,
                          files: files).process
  end

  def return_data_for_translation
    GetTextFromApi.new(api_url: api_url, params: params, more_than_one_page: more_than_one_page,
                       result_key: result_key).process
  end
end
