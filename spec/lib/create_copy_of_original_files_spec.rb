# frozen_string_literal: true

describe CreateCopyOfOriginalFiles do
  input_file_path = 'test1'
  File.open(input_file_path, 'w') do |f|
    f.write('test1')
    f.close
  end

  input_file_path2 = 'test2.txt'
  File.open(input_file_path2, 'w') do |f|
    f.write('test2')
    f.close
  end

  input_file_path3 = 'test3.txt'
  File.open(input_file_path3, 'w') do |f|
    f.write('test3')
    f.close
  end

  input_file_path4 = 'test3_original.txt'
  File.open(input_file_path4, 'w') do |f|
    f.write('test123')
    f.close
  end

  describe '.process' do
    context 'given file path without extension' do
      it 'creates new file with + "_original" in the end of file name' do
        CreateCopyOfOriginalFiles.new(file_path: input_file_path).process
        input = File.read("#{input_file_path}_original")
        expect(input).to eq('test1')
        File.delete(input_file_path)
        File.delete("#{input_file_path}_original")
      end
    end
    context 'given file path with extension' do
      it 'creates new file with + "_original" in the end of file name before extention' do
        CreateCopyOfOriginalFiles.new(file_path: 'test2.txt').process
        input = File.read('test2_original.txt')
        expect(input).to eq('test2')
        File.delete(input_file_path2)
        File.delete('test2_original.txt')
      end
    end
    context 'given file path which already exists' do
      it 'does not create new file' do
        CreateCopyOfOriginalFiles.new(file_path: input_file_path3).process
        input = File.read('test3_original.txt')
        expect(input).to eq('test123')
        File.delete(input_file_path3)
        File.delete(input_file_path4)
      end
    end
  end
end
