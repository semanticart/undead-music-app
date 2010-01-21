class LastFMExtractor
  attr_accessor :matches

  def initialize(user)
    top_artists = user.top_artists
    q = top_artists.map{|x| mbid_or_name(x)} + user.recent_tracks.map{|x| artist_mbid_or_artist(x)}
    @matches = ArtistAPI.all(:q => q.uniq)
  end

  def artist_mbid_or_artist(track)
    unless track.artist_mbid.blank?
      track.artist_mbid
    else
      track.artist
    end
  end

  def mbid_or_name(artist)
    unless artist.mbid.blank?
      artist.mbid
    else
      artist.name
    end
  end
end

