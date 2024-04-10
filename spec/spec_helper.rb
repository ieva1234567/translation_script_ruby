# frozen_string_literal: true

require_relative '../require_classes'
RequireClasses.process(['./lib'])
require 'json'
require 'active_support'
require 'active_support/core_ext'
require 'net/http'
require 'pry'
