require "minitest_helper"

describe 'Database seeds' do
  it "must seed without problem" do
    require File.join(File.dirname(__FILE__), '../..', 'db/seeds')
  end
end
