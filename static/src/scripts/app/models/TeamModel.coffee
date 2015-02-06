define [
  "jquery"
  "underscore"
  "backbone"
  "mixen"
  "mixens/AuthMixen"
], ($, _, Backbone, Mixen, AuthMixen) ->
  class Team extends Mixen(AuthMixen, Backbone.Model)
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