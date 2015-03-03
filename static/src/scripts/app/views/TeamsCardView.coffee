define [
  "jquery"
  "underscore"
  "backbone"
  "jade.templates"
], ($, _, Backbone, jade) ->
  class TeamCardView extends Backbone.View
    template: jade.teamCardView
