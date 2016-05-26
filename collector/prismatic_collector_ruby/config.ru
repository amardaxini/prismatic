require 'rubygems'
require 'sinatra'
#require 'sinatra/reloader'
require './prismatic_collector'
require 'sinatra/cross_origin'
require "bunny"

enable :logging
set :environment, :development
set :port, 6000
enable :cross_origin
set :allow_origin, :any
set :allow_methods, [:get, :post, :options]
run Sinatra::Application