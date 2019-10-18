module Punk
  module API
    BASE = 'https://api.punkapi.com/v2/beers/'.freeze

    # +Path+ module
    module Path
      PAGE = '?page='.freeze
      PER_PAGE = '?per_page='.freeze
      NAME = '?beer_name='.freeze
      ABV_GT = '?abv_gt='.freeze
      ABV_LT = '?abv_lt='.freeze
    end

    # Makes a call to Punk's API and returns a JSON woth the response
    def self.api_call!(path = nil, params = nil)
      url = "#{BASE}#{path}#{params}"
      response = Faraday.get(url)
      json = JSON.parse(response.body, symbolize_names: true)
      # Removes undesired attributes, only leaves what requested
      json.map! { |beer| beer.slice(:id, :name, :tagline, :description, :abv) }
      # Adds the 'seen_at' field to the beers
      json.each { |beer| beer[:seen_at] = DateTime.now }
      # Adds the 'punk_id' field to the beers
      json.each { |beer| beer[:punk_id] = beer.delete(:id) }
      json
    end

    # Gets ALL beers from Punk API
    # @return [JSON] JSON parsed response from Punk API
    # @raise Faraday::Exception
    def self.all_beers!(params)
      path = ''
      path += Path::PAGE + params[:page] + '&' if params[:page]
      path += Path::PER_PAGE + params[:per_page] + '&' if params[:per_page]
      path = path.sub('&?', '&')
      api_call!(path, nil)
    end

    # Gets ALL beers from Punk API
    # @return [JSON] JSON parsed response from Punk API
    # @raise Faraday::Exception
    def self.one_beer!(beer_id)
      api_call!(nil, beer_id)
    end

    # Gets beers that match 'beer_name'
    # @return [JSON] JSON parsed response from Punk API
    # @raise Faraday::Exception
    def self.beers_name!(beer_name)
      api_call!(Path::NAME, beer_name)
    end

    # Gets beers with ABV greater than specified
    # @return [JSON] JSON parsed response from Punk API
    # @raise Faraday::Exception
    def self.beers_abv_gt!(abv)
      api_call!(Path::ABV_GT, abv)
    end

    # Gets beers with ABV less than specified
    # @return [JSON] JSON parsed response from Punk API
    # @raise Faraday::Exception
    def self.beers_abv_lt!(abv)
      api_call!(Path::ABV_LT, abv)
    end
  end
end
