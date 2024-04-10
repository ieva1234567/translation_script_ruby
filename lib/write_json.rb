# frozen_string_literal: true

class WriteJson
  def self.process(hash_to_write: {}, file_path: "")
    last_index = hash_to_write.count - 1
    File.open(file_path, 'w') do |f|
      f.write("{\n")
      hash_to_write.each_with_index do |(key, value), index|
        f.write("\t" + '"' + key + '": "' + value.gsub('\n', '\\n') + '"')
        f.write(",\n") unless index == last_index
      end
      f.write("\n}")
      f.close
    end
  end

end
