require 'spec_helper'

describe AmsaMason do
  it 'has a version number' do
    expect(AmsaMason::VERSION).not_to be nil
  end
end

describe AmsaMason do
  let(:parsed_mason) do
    JSON.parse(File.read('spec/support/mason.json'))
  end
  let(:model) { AmsaMason::ResourceModel.new(title: "Title") }
  let(:serializer) { AmsaMason::ResourceSerializer.new(model) }

  it 'defines an Adapter' do
    expect(AmsaMason::Adapter.new(serializer)).to be_a AmsaMason::Adapter
  end

  it 'serializes Mason correctly' do
    adapter = AmsaMason::Adapter.new(serializer)
    expect(JSON.parse(adapter.as_json)).to eq(parsed_mason)
  end
end
