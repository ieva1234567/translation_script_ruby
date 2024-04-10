describe TranslateMissingKeys do
  describe '.process' do
    context 'when there is more keys in prime hash' do
      it 'return new hash with translated key values' do
        test_hash = TranslateMissingKeys.new(prime_hash: { 'diena' => 'diena', 'valanda' => 'valanda' },
                                             hash_to_trans: { 'valandos' => 'hours' },
                                             langpair: 'lt|en').process
        expect(test_hash).to eq({ 'diena' => 'day', 'valanda' => 'hour' })
      end
    end
  end
end
