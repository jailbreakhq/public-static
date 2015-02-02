define [
  "jquery"
  "underscore"
  "backbone"
  "mixen"
  "mixens/AuthMixen"
  "models/TeamModel"
], ($, _, Backbone, Mixen, AuthMixen, Team) ->
  class Teams extends Mixen(AuthMixen, Backbone.Collection)
    model: Team
    filters: null

    url: =>
      if @filters
        jailbreak.api_host + "/teams?filters=" + encodeURIComponent JSON.stringify @filters
      else
        jailbreak.api_host + "/teams"

    initialize: (data, options) ->
      if options
        @filters = options.filters