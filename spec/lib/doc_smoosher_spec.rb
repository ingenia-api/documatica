require 'spec_helper'

class TestSmoosher
  extend DocSmoosher::TopLevel
end

describe DocSmoosher do
  it 'loads' do
    DocSmoosher.should_not be_nil
  end


  describe 'top level methods' do

    let :smoosher do
      TestSmoosher.new
    end

    describe 'lets you define' do
      it 'an API' do
        TestSmoosher.define_api(name: 'test api'){}.should be_true
      end

      it 'a request' do
        TestSmoosher.define_request(name: 'new request'){}.should be_true
      end
    end
  end
end