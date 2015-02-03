define [
  "jquery"
  "underscore"
  "backbone"
  "mixen"
  "mixens/AuthMixen"
], ($, _, Backbone, Mixen, AuthMixen) ->
  class Team extends Mixen(AuthMixen, Backbone.Model)
    urlRoot: jailbreak.api_host + "/teams"
    defaults:
      avatar: "https://static.jailbreakhq.org/avatars/jb-default-avatar.jpg"