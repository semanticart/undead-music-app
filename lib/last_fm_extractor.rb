class LastFMExtractor
  attr_accessor :matches

  def initialize(user)
    top_artists = user.top_artists
    mids = top_artists.map{|x| x.mbid} + user.recent_tracks.map{|x| x.artist_mbid}
    @matches = ArtistAPI.all(:mbids => mids)
  end
end

