require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

require_relative "cookbook"
require_relative "recipe"

get '/' do
  cookbook = Cookbook.new(File.join(__dir__, 'recipes.csv'))
  @recipes = cookbook.all
  erb :index
end

get '/new' do
  erb :new
end

post '/recipes' do
  cookbook = Cookbook.new(File.join(__dir__, 'recipes.csv'))
  recipe = Recipe.new(params)
  cookbook.add(recipe)
  redirect to '/'
end

get '/recipes/delete/:index' do
  cookbook = Cookbook.new(File.join(__dir__, 'recipes.csv'))
  cookbook.remove_at(params[:index].to_i)
  redirect to '/'
end

get '/recipes/done/:index' do
  cookbook = Cookbook.new(File.join(__dir__, 'recipes.csv'))
  cookbook.mark_recipe_as_done(params[:index].to_i)
  redirect to '/'
end