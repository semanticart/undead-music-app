class ArtistAPI
  def self.all conditions = {}
    if conditions[:names] || conditions[:mbids]
      key = (conditions[:names] ? :names : :mbids)
      JSON.parse(RestClient.post("#{CONFIG[:api_url]}/api/artists/list.json", key => conditions[key].join('|')))
    else
      # TODO: better error
      raise "you must pass mids or names"
    end
  end
end
