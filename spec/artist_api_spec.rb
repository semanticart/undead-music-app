require File.dirname(__FILE__)+ "/spec_helper.rb"

describe ArtistAPI do
  EXPECTED = {
    "mogwai" => "d700b3f5-45af-4d02-95ed-57d301bda93e",
    "the smashing pumpkins" => "ba0d6274-db14-4ef5-b28d-657ebde1a396"
  }

  context "#all" do
    context "finding artists matching a list of musicbrainz ids" do
      it "should return matches if there are any" do
        res = ArtistAPI.all(:mbids => EXPECTED.values + ['abc123'])
        res.map{|x| x['name']}.sort.should == EXPECTED.keys.sort
      end

      it "should return an empty array if there are no matches" do
        ArtistAPI.all(:mbids => ['abc123']).should == []
      end
    end

    context "finding artists matching a list of names" do
      it "should return matches if there are any" do
        # replace the so we find "smashing pumpkins" (which is an alias)
        # mogwai is not aliased
        res = ArtistAPI.all(:names => EXPECTED.keys.map{|x| x.sub(/the /, '')} + ["robocop versus the devil"])
        res.map{|x| x['mid']}.sort.should == EXPECTED.values.sort
      end

      it "should return an empty array if there are no matches" do
        ArtistAPI.all(:names => ["robocop versus the devil", "eight ninjas stole my sandwich"]).should == []
      end
    end
  end
end
