# frozen_string_literal: true

class CreateCopyOfOriginalFiles
  attr_reader :file_path

  def initialize(file_path: '')
    @file_path = file_path
  end

  def process
    new_file_path = create_new_file_name(file_path)
    FileUtils.cp file_path, new_file_path unless File.file?(new_file_path)
  end

  private

  def create_new_file_name(file_path)
    splitted_path = file_path.split('/')
    extension_index = splitted_path.last.index('.')
    new_file_name = if extension_index.present?
                      "#{splitted_path.last[0...extension_index]}_original.#{splitted_path.last[extension_index + 1..]}"
                    else
                      "#{splitted_path.last}_original"
                    end
    splitted_path[-1] = new_file_name
    splitted_path.join('/')
  end
end
