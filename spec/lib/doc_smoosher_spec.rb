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
      it 'an API' do
        expect(TestSmoosher.define_api(name: 'test api'){}).to be_true
      end

      it 'a request' do
        expect(TestSmoosher.define_request(name: 'new request'){}).to be_true
      end
    end
  end

  describe 'DSL' do
    describe '#define_api' do
      it 'defines an api' do
        TestSmoosher.define_api(name: 'test api') do |api|
          api.description = "a test api example"
          
          # api.define_request('items') do |r|

          # end
        end

        api = TestSmoosher.api
        expect(api).not_to be_nil
        expect(api.name).to eql('test api')
        expect(api.description).to eql('a test api example')
      end
    end
  end
end