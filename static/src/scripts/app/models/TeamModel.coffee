define [
  "jquery"
  "underscore"
  "backbone"
  "mixen"
], ($, _, Backbone, Mixen) ->
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