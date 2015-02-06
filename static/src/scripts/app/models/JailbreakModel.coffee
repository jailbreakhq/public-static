define [
  "jquery"
  "underscore"
  "backbone"
], ($, _, Backbone) ->
  class Team extends Backbone.Model
    urlRoot: jailbreak.api_host + "/"
    defaults:
      amountRaised: 0
