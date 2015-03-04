define [
  "jquery"
  "underscore"
  "backbone"
  "mixen"
  "models/CheckinModel"
], ($, _, Backbone, Mixen, Checkin) ->
  class Team extends Mixen(Backbone.Model)
    url: =>
      if @slug
        jailbreak.api_host + "/teams/slug/" + @slug
      else
        jailbreak.api_host + "/teams/" + @.get("id")

    defaults:
      avatar: "https://static.jailbreakhq.org/avatars/jb-default-avatar.jpg"

    initialize: (options) =>
      if options.slug
        @slug = options.slug

    parse: (response) ->
      lastCheckin = response.lastCheckin
      if lastCheckin
        response.lastCheckin = new Checkin lastCheckin

      response

    getRenderContext: =>
      team = @.toJSON()
      if @.has('lastCheckin')
        team.lastCheckin = @.get('lastCheckin').toJSON()

      team
