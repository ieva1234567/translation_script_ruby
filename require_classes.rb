# frozen_string_literal: true

class RequireClasses
  def self.process(folders_for_require = [])
    folders_for_require.each do |folder|
      Dir.children(folder).each do |file|
        load "#{Dir.pwd}/#{folder}/#{file}"
      end
    end
  end
end
