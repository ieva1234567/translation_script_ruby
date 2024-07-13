# frozen_string_literal: true

describe GetHtmlAndTextPart do
  example_string = File.read('/home/ieva/projektai/translation_script/spec/lib/string_for_parsing_example.txt')
  parsed_string = JSON.parse File.read('/home/ieva/projektai/translation_script/spec/lib/string_parsed_example.txt')

  describe '.process' do
    context 'accepts input string with html tags' do
      it 'returns html_parts and text_parts array' do
        result = GetHtmlAndTextPart.new(string_text: example_string).process
        expect(result).to eq(parsed_string)
      end
    end
  end
end
