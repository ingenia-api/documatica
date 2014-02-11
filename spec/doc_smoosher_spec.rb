require 'spec_helper'

describe DocSmoosher do
  it 'loads' do
    smoosher = DocSmoosher.new
    smoosher.should_not be_nil
  end
end