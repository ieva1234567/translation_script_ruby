# frozen_string_literal: true

class TranslateMissingKeys
  attr_reader :prime_hash
  attr_accessor :hash_to_trans, :langpair

  def initialize(prime_hash: {}, hash_to_trans: {}, langpair: 'lt|en')
    @prime_hash = prime_hash
    @hash_to_trans = hash_to_trans
    @langpair = langpair
  end

  def process
    new_hash = {}
    (prime_hash.keys - hash_to_trans.keys).each do |un_trans_key|
      new_hash[un_trans_key] = translate(prime_hash[un_trans_key])
    end
    new_hash
  end

  private

  def translate(text)
    GetTranslationFromApi.new(text_to_translate: text, langpair: langpair).process
  end
end
