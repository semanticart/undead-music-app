class ArtistExtractor
  def self.for source
    case source
    when Scrobbler::User
      LastFMExtractor.new(source)
    when File
      ITunesExtractor.new(source)
    end
  end
end
