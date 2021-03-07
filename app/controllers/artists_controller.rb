# frozen_string_literal: true

# Public: Artist routes
class ArtistsController < ApplicationController
  before_action :set_artist, only: %i[show update destroy]

  # GET /v1/artists
  def index
    @artists = Artist.all
    paginated_array = Kaminari.paginate_array(@artists).page(1).per(limit).padding(offset)
    pagingation_metadata = { totalCount: @artists.count, moreResults: offset + limit + 1 <= @artists.count }

    render json: paginated_array, meta: pagingation_metadata, each_serializer: ArtistSerializer, adapter: :json,
           root: 'items'
  end

  # GET /v1/artists/1
  def show
    render json: @artist
  end

  # GET /v1/artists/aggregated/?
  def aggregate; end

  # POST /v1/artists
  def create
    @artist = Artist.new(artist_params)

    if @artist.save
      render json: @artist, status: :created, location: @artist
    else
      render json: @artist.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /v1/artists/1
  def update
    if @artist.update(artist_params)
      render json: @artist
    else
      render json: @artist.errors, status: :unprocessable_entity
    end
  end

  # DELETE /v1/artists/1
  def destroy
    @artist.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_artist
    @artist = Artist.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def artist_params
    params.require(:artist).permit(:first_name, :last_name, :show_name)
  end
end
