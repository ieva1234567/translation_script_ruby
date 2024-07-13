# frozen_string_literal: false

# class dedicated to get html and text part of html string, send text to translation
# and putting back translated text in html string
# it returns only first part of html text pair
# f.e. <p>text</p> -> {html_part: '<p>', text_part: 'text'}
# after this return it should be called again with different data which for current example would be '</p>'
# and should return {html_part: '</p>', text_part: nil}

class GetHtmlAndTextPart
  REMOVE_SYMBOLS = /[!@#$%^&*()_+{}\[\]:;'"\/\\?><]/

  attr_accessor :final, :symb_part, :text_part, :string_text, :index_word_of_html_tag, :index_word_of_html_attr

  def initialize(string_text: first_text)
    @final = []
    @string_text = string_text
    skip_tags = File.read("html_tags_to_skip.txt").split("\n")
    skip_attr = File.read("html_attributes_to_skip.txt").split("\n")
    @index_word_of_html_tag = MapIndexesToWords.new(string: string_text, words: skip_tags).process
    @index_word_of_html_attr = MapIndexesToWords.new(string: string_text, words: skip_attr).process
  end

  def process
    proc_text = string_text
    left_text = proc_text
    final_member = {}
    (0..proc_text.length - 1).to_a.each do |i|
      if proc_text.match(/\\/) && proc_text[i..i+1] == "\n"
        i, symb_part, proc_text = distribute_new_line_chars(proc_text, i)
        final_member[:symb_part] << symb_part
      else
        i, symb_part, text_part, text_part, proc_text = distribute_non_new_line_chars(proc_text, i)
        final_member[:symb_part] << symb_part
        final_member[:text_part] << text_part
      end
    end
  end

  def distribute_new_line_chars(proc_text, i)
    symb_part << proc_text[i..i+1]
    proc_text = proc_text[i+2..]
    i += 1
    [i, symb_part, proc_text]
  end

  def distribute_non_new_line_chars(proc_text, i)
    if proc_text.match(REMOVE_SYMBOLS)
      symb_part << proc_text[i]
      proc_text = proc_text[i+1..]
    else
      distribute_by_words(proc_text)
    end
    [i, symb_part, '', proc_text]
  end

  def distribute_by_words(text)
    binding.pry

  end
end
