class BeersController < ApplicationController
  before_action :authenticate!

  # GET and show beers with varying filtering options
  def index
    if params[:name].present?
      @json = Punk::API.beers_name!(params[:name])
    elsif params[:abv_gt].present?
      @json = Punk::API.beers_abv_gt!(params[:abv_gt])
    elsif params[:abv_lt].present?
      @json = Punk::API.beers_abv_lt!(params[:abv_lt])
    else
      @json = Punk::API.all_beers!(params)
    end

    render json: {
      beers: @json
    }
    create(@json)
  end

  # GET and A Beer with the requested 'id'
  def show
    @json = Punk::API.one_beer!(params[:id])
    render json: {
      beer: @json
    }
    create(@json)
  end

  # Create a Beer record
  def create(beers)
    beers.each do |beer|
      if Beer.where(punk_id: beer[:punk_id], user_id: @current_user.id).empty?
        @beer = Beer.new(beer)
        @beer.user_id = @current_user.id.to_i
        @beer.save!
      end
    end
  end

  # Create a FavoriteBeer record
  def set_favorite
    @json = Punk::API.one_beer!(params[:id])
    @json = @json&.first
    if FavoriteBeer.where(punk_id: @json[:punk_id], user_id: @current_user.id).empty?
      @fav_beer = FavoriteBeer.new(@json)
      @fav_beer.user_id = @current_user.id.to_i
      @fav_beer.save!
    end

    @json[:favorite] = true
    render json: {
      favorite_beer_set: @json
    }
  end

  # GET User favorite beers
  def get_favorite
    @json = FavoriteBeer&.all.where(user_id: @current_user.id).as_json

    @json.map! { |beer| beer.slice('id', 'name', 'tagline', 'description', 'abv', 'punk_id') }
    @json.each { |beer| beer[:favorite] = true }

    render json: {
      favorite_beers: @json
    }
  end

  private

  def beer_params
    params.require(:beer).permit(
      :name,
      :punk_id,
      :tagline,
      :description,
      :abv,
      :seen_at,
      :user_id
    )
  end
end
