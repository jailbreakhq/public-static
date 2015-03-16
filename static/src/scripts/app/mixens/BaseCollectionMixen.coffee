define [
  'jquery'
  'underscore'
  'backbone'
  'mixen'
  'mixens/AuthMixen'
  'mixens/LoadedMixen'
], ($, _, backbone, Mixen, AuthMixen, LoadedMixen) ->
  class BaseCollection extends Mixen(LoadedMixen, AuthMixen, Backbone.Collection)
    urlRoot: jailbreak.api_host

    url: ->
      super
      jailbreak.api_host
