# frozen_string_literal: true

describe WriteJson do
  describe '.process' do
    context 'reads file' do
      it 'returns written json' do
        input_file_path = 'input_test.txt'
        WriteJson.process(hash_to_write: {'test' => 'this is a test', 'test2' => 'this is a test2'}, 
                          file_path: 'input_test.txt')
        input = File.read('input_test.txt')
        expect(input).to eq("{\n\t" + '"test": "this is a test",' + "\n\t" + '"test2": "this is a test2"' + "\n}")
        File.delete(input_file_path)
      end
    end
  end
end
