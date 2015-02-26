define [
  "jquery"
  "underscore"
  "backbone"
], ($, _, Backbone) ->
  class Jailbreak extends Backbone.Model
    urlRoot: jailbreak.api_host + "/"
    defaults:
      amountRaised: 0
