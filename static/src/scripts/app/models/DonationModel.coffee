define [
  "jquery"
  "underscore"
  "backbone"
  "mixen"
], ($, _, Backbone, Mixen) ->
  class Donation extends Mixen(Backbone.Model)
    # empty -- spooky