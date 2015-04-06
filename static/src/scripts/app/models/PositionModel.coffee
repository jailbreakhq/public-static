define [
  'backbone'
], (Backbone) ->
  class Position extends Backbone.Model
    defaults:
      lat: ''
      lon: ''
      location: ''