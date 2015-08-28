Rails.application.routes.draw do
  root 'welcome#results'

  get '/pages/results', to: 'welcome#results', as: 'results'
  get '/pages/explore', to: 'welcome#explore', as: 'explore'
end
