class ArtistAPI
  def self.all conditions = {}
    if conditions.keys.any?{|key| [:names, :mbids, :q].include?(key)}
      joined_conditions = conditions.inject({}){|hash, pair| hash[pair[0]] = pair[1].join('|'); hash}
      JSON.parse(RestClient.post("#{CONFIG[:api_url]}/api/artists/list.json", joined_conditions))
    else
      # TODO: better error
      raise "you must pass :mbids, :names, or :q"
    end
  end
end
