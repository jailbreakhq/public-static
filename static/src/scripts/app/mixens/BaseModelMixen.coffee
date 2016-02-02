define [
  'backbone'
  'mixen'
  'mixens/AuthMixen'
  'mixens/SyncingMixen'
], (backbone, Mixen, AuthMixen, SyncingMixen) ->
  class BaseModel extends Mixen(SyncingMixen, AuthMixen, Backbone.Model)
    urlRoot: jailbreak.api_host

    sync: ->
      # don't remove
      super
