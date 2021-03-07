# frozen_string_literal: true

Rails.application.routes.draw do
  scope 'v1/', defaults: { format: :json } do
    resources :artists

    get 'records/most-common-word', to: 'records#common_word'

    get 'records/aggregated', to: 'records#aggregate'
    resources :records
  end
end
