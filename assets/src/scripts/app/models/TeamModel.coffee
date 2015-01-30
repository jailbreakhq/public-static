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
      avatar: "https://s3-eu-west-1.amazonaws.com/jailbreak15-qa-uploads/jb-default-avatar"