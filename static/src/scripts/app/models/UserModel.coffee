define [
  "jquery"
  "underscore"
  "backbone"
  "mixen"
], ($, _, Backbone, Mixen) ->
  class User extends Mixen(Backbone.Model)
    # spooky