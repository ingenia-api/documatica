require 'spec_helper'

describe DocSmoosher::Api do
  let :api do
    DocSmoosher::Api.new(name: 'test api') do |api|
      api.description = 'a test api example'
    end
  end

  describe 'DSL' do
    describe '#define_api' do
      it 'defines an api' do
        expect(api).not_to be_nil
        expect(api.name).to eql('test api')
        expect(api.description).to eql('a test api example')
      end
    end
  end
end