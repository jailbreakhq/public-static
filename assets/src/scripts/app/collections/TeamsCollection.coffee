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
    url: jailbreak.api_host + "/teams"