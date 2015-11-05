require 'spec_helper'

describe AmsaMason do
  it 'has a version number' do
    expect(AmsaMason::VERSION).not_to be nil
  end
end

describe AmsaMason do
  before(:each) do
    allow(Socket).to receive(:gethostname).
      and_return('http://issue-tracker.org')
  end
  let(:parsed_mason) do
    JSON.parse(File.read('spec/support/mason.json')).merge!(
      '@namespaces' =>{
        "is"=>{
          "name"=>"http://elfisk.dk/mason/issue-tracker/reltypes.html#"
        }
      }
    )
  end
  let(:mason_as_hash) do
    {
      id: 1,
      title: "Program crashes when pressing ctrl-p",
      description: "I pressed ctrl-p and, boom, it crashed.",
      severity: 5,
      attachments: [
        id: 1,
        title: "Error report"
      ]
    }
  end
  let(:model) do
    AmsaMason::Issue.new(
      mason_as_hash
    )
  end
  let(:serializer) { AmsaMason::IssueSerializer.new(model) }

  it 'defines an Adapter' do
    expect(AmsaMason::Adapter.new(serializer)).to be_a AmsaMason::Adapter
  end

  describe 'without is: actions/templates or profile info' do
    before(:each) do
      allow_any_instance_of(AmsaMason::Adapter).
        to receive(:instance_options).
        and_return({minimal: true})
      allow_any_instance_of(AmsaMason::IssueSerializer).
        to receive(:actions).and_return([])
    end
    it 'adds appropriate controls' do
      parsed_json = JSON.parse(AmsaMason::Adapter.new(serializer).as_json)
      expect(parsed_json['@controls']).to eq(parsed_mason['@controls'])
    end
    it 'serializes Mason correctly' do
      adapter = AmsaMason::Adapter.new(serializer)
      expect(JSON.parse(adapter.as_json)).to eq(parsed_mason)
    end
  end

  it 'adds is: relations and templates' do
    parsed_is_mason = JSON.parse(File.read('spec/support/mason_is.json'))
    parsed_json = JSON.parse(AmsaMason::Adapter.new(serializer).as_json)
    expect(parsed_json).to eq(parsed_is_mason)
  end

  describe 'using common resource document' do
    let(:issue_tracker_root_parsed) do
      JSON.parse(File.read('spec/support/resource-common.json'))
    end
    let(:parsed_json) do
      JSON.parse(AmsaMason::Adapter.new(serializer).as_json)
    end

    it 'adds namespaces' do
      expect(parsed_json['@namespaces']).to eq(issue_tracker_root_parsed['@namespaces'])
    end
    it 'adds meta information' do
      expect(parsed_json['@meta']).to eq(issue_tracker_root_parsed['@meta'])
    end
    it 'removes meta when minimal is set' do
      expect_any_instance_of(AmsaMason::Adapter).
        to receive(:instance_options).at_least(:twice).
        and_return({minimal: true})
      expect(parsed_json['@meta']).to be_nil
    end
    it 'communicates schemas' do
      expect(parsed_json).to eq(issue_tracker_root_parsed)
    end
  end
end
