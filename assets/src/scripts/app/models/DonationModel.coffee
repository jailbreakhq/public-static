define [
  "jquery"
  "underscore"
  "backbone"
  "mixen"
  "mixens/AuthMixen"
], ($, _, Backbone, Mixen, AuthMixen) ->
  class Donation extends Mixen(AuthMixen, Backbone.Model)
    # empty -- spooky