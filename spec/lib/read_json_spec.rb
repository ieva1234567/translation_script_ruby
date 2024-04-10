# frozen_string_literal: true

describe ReadJson do
  input_file_path = 'input_test.txt'
  File.open(input_file_path, 'w') do |f|
    f.write("{\n" + '"test": "this is a test",' + "\n" + '"test2": "this is a test2"' + "\n}")
    f.close
  end

  describe '.process' do
    context 'reads file' do
      it 'returns written json' do
        input = ReadJson.process(file_path: 'input_test.txt')
        expect(input).to eq({ "test"=> 'this is a test', "test2"=> 'this is a test2' })
        File.delete(input_file_path)
      end
    end
  end
end
