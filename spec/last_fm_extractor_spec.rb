require File.dirname(__FILE__)+ "/spec_helper.rb"

describe LastFMExtractor do
  before(:each) do
    @scrobbler = Scrobbler::User.new("violencenow")
    @scrobbler.stub!(:top_artists).and_return(LASTFM_SAMPLE[:top_artists])
    @scrobbler.stub!(:recent_tracks).and_return(LASTFM_SAMPLE[:recent_tracks])
  end

  context "extracting artists from recent and top artists" do
    it "returns artists on a valid request" do
      LastFMExtractor.new(@scrobbler).matches.map{|x| x['name']}.should =~ ["explosions in the sky", "minus the bear", "modest mouse", "mogwai", "the appleseed cast"]
    end
  end
end
