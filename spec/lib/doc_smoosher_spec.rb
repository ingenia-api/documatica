require 'spec_helper'

class TestSmoosher
  extend DocSmoosher::TopLevel
end

describe DocSmoosher do
  it 'loads' do
    expect(DocSmoosher).not_to be_nil
  end


  describe 'top level methods' do

    describe 'lets you define' do
      it 'an Api' do
        expect(TestSmoosher.define_api(name: 'test api'){}).to be_true
      end

      it 'a parameter' do
        expect(TestSmoosher.define_parameter(name: 'test param'){}).to be_true
      end

      it 'keeps track of shared parameters' do
        TestSmoosher.define_parameter(name: 'test param'){}

        expect(TestSmoosher.parameters.first.name).to eql('test param')
      end
    end
  end

  describe 'DSL' do
    describe '#define_api' do
      it 'defines an api' do
        TestSmoosher.define_api(name: 'test api') do |api|
          api.description = "a test api example"
        end

        api = TestSmoosher.api
        expect(api).not_to be_nil
        expect(api.name).to eql('test api')
        expect(api.description).to eql('a test api example')
      end
    end
  end
end