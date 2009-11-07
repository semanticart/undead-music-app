class ITunesExtractor
  attr_accessor :matches

  def initialize(file)
    lines = file.readlines
    artist_names = lines.map do |line|
      match = line.match("<key>Artist</key><string>(.*?)</string>")
      match[1].downcase.strip if match
    end.compact.uniq

    @matches = ArtistAPI.all(:names => artist_names)
  end
end
