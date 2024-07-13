# frozen_string_literal: true

describe MapIndexesToWords do
  describe '.process' do
    context 'accepts string and words' do
      it 'returns word -> indexes hash' do
        result = MapIndexesToWords.new(string: '<title>Diena valanda title the thetitle</title>',
                                       words: %w[title the]).process
        expect(result).to eq({ "title" => [1, 21, 41], "the" => [27] })
      end
    end
  end
end
