# frozen_string_literal: true

# Public Record rouates
class RecordsController < ApplicationController
  before_action :set_record, only: %i[show update destroy]

  # GET /v1/records
  # Thought: Could optionally support simple lookups by name, etc
  # Thought: Could allow sending in order_by
  def index
    raise RecordErrors::BadRequestError, 'Invalid pagination params' unless valid_paginate_params?(offset, limit)

    # could pass in limit and offset to speed up call but lose count
    @records = Record.filter_records(where: flatten_array_params('where'))

    paginated_array = Kaminari.paginate_array(@records).page(1).per(limit).padding(offset)
    pagingation_metadata = { totalCount: @records.count, moreResults: offset + limit + 1 <= @records.count }

    render json: paginated_array, meta: pagingation_metadata, each_serializer: RecordSerializer, adapter: :json,
           root: 'items'
  end

  # GET /v1/records/1
  def show
    render json: @record
  end

  # GET /v1/records/most-common-word
  def common_word
    render json: Record.most_common_word
  end

  # GET /v1/records/aggregated?function=*&where=*:*&group_by=*
  # Thought: Could tear aggregation out into its own model
  #
  # function - The desired stastic function
  # where    - The array of equivalency checks added together via ORs. eg ?where=attribute:value_to_equal
  # group_by - Whether things need to be grouped
  def aggregate
    aggregated_stats = if aggregate_params[:group_by]
                         Record.aggregate_by_group(
                           function: aggregate_params[:function],
                           where: flatten_array_params('where'),
                           group_by: aggregate_params[:group_by]
                         )
                       else
                         Record.aggregate(function: aggregate_params[:function], where: flatten_array_params('where'))
                       end
    render json: aggregated_stats.to_json
  end

  # POST /v1/records
  def create
    @record = Record.new(record_params)

    if @record.save
      render json: @record, status: :created, location: @record
    else
      render json: @record.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /v1/records/1
  def update
    if @record.update(record_params)
      render json: @record
    else
      render json: @record.errors, status: :unprocessable_entity
    end
  end

  # DELETE /v1/records/1
  def destroy
    @record.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_record
    @record = Record.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def record_params
    params.permit(:title, :year, :condition, :description, artist_ids: [])
  end

  # To be used for aggregate route
  def aggregate_params
    params.permit(:function, :where, :group_by)
  end
end
