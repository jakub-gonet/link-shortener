# frozen_string_literal: true

RSpec.shared_examples 'a hash with elements' do
  it 'has type Hash' do
    expect(hash).to be_a(Hash)
  end
  it 'has some elements' do
    expect(hash).not_to be_empty
  end
end

RSpec.shared_examples 'an empty hash' do
  it 'has type Hash' do
    expect(hash).to be_a(Hash)
  end
  it 'does not have any elements' do
    expect(hash).to be_empty
  end
end
