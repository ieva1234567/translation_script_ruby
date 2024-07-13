# frozen_string_literal: true

require 'json'
require 'net/https'
require 'pry'
require 'active_support'
require 'active_support/core_ext'
require_relative 'require_classes'
RequireClasses.process(['./lib'])

CreateTranslations.new(class_params: { api_url: 'http://localhost:3000/api/v1/recipes/index',
                                       params:  { page: 1, sIdentifier: 'la_maistas' },
                                       more_than_one_page: false,
                                       result_key: 'result', trans_keys: ['title'],
                                       lng: { prime: 'lt', to_trans: 'en' },
                                       files: { main: './locales/lt/translation.json',
                                                for_translation: './locales/en/translation.json' } }).process
                                                                                        
