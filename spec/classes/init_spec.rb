require 'spec_helper'
describe 'people' do

  context 'with defaults for all parameters' do
    it { should contain_class('people') }
  end
end
