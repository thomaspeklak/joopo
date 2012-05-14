require "joopo/version"
require 'yaml'
require 'sinatra/base'
require 'net/http'
require 'open-uri'
require 'uri'

module Joopo
  class Proxy < Sinatra::Base

    config = (ARGV.size == 0) ? 'proxy.yaml' : ARGV[0]
    raise ArgumentError, "'#{config}' file does not exist" if(!File.exists?(config))

    settings = YAML.load(File.open(config))
    settings['public_folder'] ||= 'public'
    settings['port'] ||= 4567
    settings['apis'] ||= {}

    set :root, Dir.pwd
    set :static, true
    set :public_folder, File.join(root, settings['public_folder'])
    puts "Static files servered from: " + File.join(root, settings['public_folder'])

    set :port, settings['port']

    get '/:api/*' do
      api = params[:api]
      pass unless settings['apis'].has_key?(params[:api])
      if settings['apis'][api].class == Hash
        content_type settings['apis'][api]['content_type']
        settings['apis'][api]['content']
      else
        response = open(settings['apis'][api] + params['splat'].first + '?' + hash_to_querystring(params.clone))
        content_type response.content_type
        response.read
      end
    end

    post '/:api/*' do
      api = params[:api]
      pass unless settings['apis'].has_key?(params[:api])

      if settings['apis'][api].class == Hash
        content_type settings['apis'][api]['content_type']
        settings['apis'][api]['content']
      else
        query_params = request.env['QUERY_STRING']
        post_vars = request.env["rack.request.form_hash"]

        uri = URI.parse(settings['apis'][api] + params['splat'].first + '?' + query_params)

        response = Net::HTTP.post_form(uri, post_vars)
        content_type response.content_type
        response.body
      end
    end

    def hash_to_querystring(hash)
      hash.delete('splat')
      hash.delete('captures')
      hash.keys.inject('') do |query_string, key|
        query_string << '&'  << "#{URI.encode(key.to_s)}=#{URI.encode(hash[key])}"
      end
    end

    run! if app_file == $0
  end
end

