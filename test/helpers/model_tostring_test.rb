require "minitest_helper"

models = ActiveRecord::Base.descendants

models.each do |model|
  describe model do
    before do
      @model_sym = model.to_s.underscore.to_sym
    end

    it 'must have a factory' do
      Factory.create(@model_sym).wont_be_nil 'Missing or invalid factory'
    end

    describe 'to_s method' do
      before do
        @obj = Factory.create(@model_sym)
      end

      it "must return something sensible" do
        @obj.to_s.wont_match /^#<.*>$/, 'not sensible'
      end
    end
  end
end
