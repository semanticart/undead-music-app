
require File.dirname(__FILE__)+ "/spec_helper.rb"

describe ITunesExtractor do
  context "extracting artists names" do
    it "returns artists on a valid file" do
      ITunesExtractor.new(File.new(ITUNES_LIBRARY_FILE)).matches.map{|x| x['name']}.should == ["harvey danger"]
    end
  end
end
