# frozen_string_literal: true

class ReadJson
  def self.process(file_path: '')
    file = File.read(file_path)
    JSON.parse(file)
  end
end
