# frozen_string_literal: true

# tarns_keys - keys from trans_arr to be translated f.e.['title', 'about'],
# lng - prime: language shortname used in trans_keys, to_trans: language shortname used in which translations should be made
# files - main: where text should be copied from trans_arr, for_translation: where text should be translated
class AddKeysToMainFile
  attr_reader :trans_keys, :prime_lng_shrtname, :trans_arr, :main_file_path, :files, :lng, :langpair_str
  attr_accessor :prime_hash, :to_trans_hash

  def initialize(trans_keys: [], lng: { prime: 'lt', to_trans: 'en' }, trans_arr: [],
                 files: { main: './locales/lt/translation.json', for_translation: './locales/en/translation.json' })
    @trans_keys = trans_keys
    @prime_lng_shrtname = prime_lng_shrtname
    @lng = lng
    @trans_arr = trans_arr
    @main_file_path = main_file_path
    @files = files
    @prime_hash = {}
    @to_trans_hash = {}
    @langpair_str = "#{lng[:prime]}|#{lng[:to_trans]}"
  end

  def process
    create_copy_of_original_files
    read_files
    translate_missing_keys
    add_translations_to_hashes
    write_translations_to_files
  end

  def translate_missing_keys
    to_trans_hash.merge(TranslateMissingKeys.new(prime_hash: prime_hash, hash_to_trans: to_trans_hash,
                                                 langpair: langpair_str).process)
  end

  def create_copy_of_original_files
    CreateCopyOfOriginalFiles.new(file_path: files[:main]).process
    CreateCopyOfOriginalFiles.new(file_path: files[:for_translation]).process
  end

  def add_translations_to_hashes
    trans_arr.each do |translatable_hash|
      trans_keys.each do |trans_key|
        add_keys_with_translations(translatable_hash, trans_key)
      end
    end
  end

  private

  def write_translations_to_files
    WriteJson.process(hash_to_write: prime_hash, file_path: files[:main])
    WriteJson.process(hash_to_write: to_trans_hash, file_path: files[:for_translation])
  end

  def add_keys_with_translations(translatable_hash, trans_key)
    formatted_key = format_key(translatable_hash, trans_key)
    if prime_hash[formatted_key].present? || to_trans_hash[formatted_key].present?
      puts "#{formatted_key} already exists. Skipping ..."
    else
      prime_hash[formatted_key] = translatable_hash[trans_key]#.gsub('"', '')
      add_key_to_trans_hash(formatted_key, translatable_hash[trans_key])
    end
  end

  def format_key(translatable_hash, trans_key)
    ActiveSupport::Inflector.transliterate(translatable_hash[trans_key]).downcase.gsub(/[^a-zA-Z\s.]/, '').gsub(' ', '_')
  end

  def add_key_to_trans_hash(ft_key, value_to_trans)
    to_trans_hash[ft_key] = get_translation_from_my_memory(value_to_trans)
  end

  def get_translation_from_my_memory(value_to_trans)
    GetTranslationFromApi.new(text_to_translate: value_to_trans, langpair: langpair_str).process
  end

  def read_files
    @prime_hash = ReadJson.process(file_path: files[:main])
    @to_trans_hash = ReadJson.process(file_path: files[:for_translation])
  end
end
