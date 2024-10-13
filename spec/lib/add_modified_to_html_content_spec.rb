# frozen_string_literal: true

describe AddModifiedToHtmlContent do
  example_string =
  '<html>
    <body>
      <h1 class="title" id="header">Hello, World!</h1>
      <p class="description">This is a paragraph.</p>
      <div class="container">Here is a div with <strong>bold text</strong>.</div>
      <footer>Footer content here.</footer>
    </body>
  </html>'

  expected_string_doc = Nokogiri::XML('<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
  <html>
    <body>
      <h1 class="title" id="header">Modified: Hello, World!</h1>
      <p class="description">Modified: This is a paragraph.</p>
      <div class="container">Modified: Here is a div with<strong>Modified: bold text</strong>Modified: .</div>
      <footer>Modified: Footer content here.</footer>
    </body>
  </html>',  &:noblanks)

  describe '.process' do
    context 'accepts input string with html tags' do
      it 'returns changed html string' do
        result = Nokogiri::XML(AddModifiedToHtmlContent.new(html: example_string, langpair: 'lt|en').process, &:noblanks)
        expect(result.to_xhtml).to eq(expected_string_doc.to_xhtml)
      end
    end
  end
end
