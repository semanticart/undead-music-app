require File.dirname(__FILE__)+ "/spec_helper.rb"

describe ArtistExtractor do
  context "determining which extractor to use" do
    it "returns a LastFM extractor when passed a Scrobbler::User" do
      ArtistExtractor.for(Scrobbler::User.new("violencenow")).class.should == LastFMExtractor
    end

    it "returns an iTunes extractor when passed an iTunes Library file" do
      ArtistExtractor.for(File.new(ITUNES_LIBRARY_FILE)).class.should == ITunesExtractor
    end
  end
end
