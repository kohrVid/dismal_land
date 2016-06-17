require 'spec_helper'

RSpec.describe "PadrinoDismaland::App::CommentsHelper" do
  pending "add some examples to (or delete) #{__FILE__}" do
    let(:helpers){ Class.new }
    before { helpers.extend PadrinoDismaland::App::CommentsHelper }
    subject { helpers }

    it "should return nil" do
      expect(subject.foo).to be_nil
    end
  end
end
