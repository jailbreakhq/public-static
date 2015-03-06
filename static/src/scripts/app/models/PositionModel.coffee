define [
  "jquery"
  "underscore"
  "backbone"
], ($, _, Backbone) ->
  class Position extends Backbone.Model
    defaults:
      lat: ''
      lon: ''
      location: ''