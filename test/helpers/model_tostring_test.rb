require "minitest_helper"

ActiveRecord::Base.descendants.each do |model|
  describe model do
    before do
      @obj = model.new
    end

    describe 'to_s method' do
      it "must return something sensible" do
        @obj.to_s.wont_match /^#<.*>$/, 'not sensible'
      end
    end
  end
end
