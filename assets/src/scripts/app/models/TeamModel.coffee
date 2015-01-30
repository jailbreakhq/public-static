define [
  "jquery"
  "underscore"
  "backbone"
  "mixen"
  "mixens/AuthMixen"
], ($, _, Backbone, Mixen, AuthMixen) ->
  class Team extends Backbone.Model
    urlRoot: jailbreak.api_host + "/teams"
    defaults:
      avatar: "http://qa.static.jailbreakhq.org/avatars/jb-default-avatar.jpeg"