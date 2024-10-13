# frozen_string_literal: true

require 'nokogiri'

class AddModifiedToHtmlContent
  attr_reader :html, :langpair

  def initialize(html: '', langpair: 'lt|en')
    @html = html
    @langpair = langpair
  end

  def process
    # Parse the HTML string
    doc = Nokogiri::HTML(html)
    # Iterate through all text nodes and modify their content
    doc.traverse do |node|
      # Check if the node is a text node
      if node.text?
        # Modify the text as per your requirement (example: prepend "Modified: ")
        node.content = 'Modified: ' + node.content.strip unless node.content.strip.empty?
      end
    end
    doc.to_html
  end
end
