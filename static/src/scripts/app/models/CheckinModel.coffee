define [
  'jquery'
  'underscore'
  'backbone'
  'mixen'
  'mixens/BaseModelMixen'
], ($, _, Backbone, Mixen, BaseModelMixen) ->
  class Checkin extends Mixen(BaseModelMixen)

    initialize: (options) ->
      @teamId = options.teamId

      super

    url: ->
      jailbreak.api_host + '/teams/' + @teamId + '/checkins'

    getRenderContext: ->
      @.toJSON()

    parse: (response) ->
      team = response.team
      if team
        response.team = @parseTeam team

      response

    parseTeam: (response) ->
      lastCheckin = response.lastCheckin
      if lastCheckin
        response.lastCheckin = new Checkin lastCheckin

      response
