define [
  "jquery"
  "underscore"
  "backbone"
  "jade.templates"
], ($, _, Backbone, jade) ->
  class TeamCardView extends Backbone.View
    template: jade.teamCard
    
    initialize: =>
      @model.bind "change", @render

    render: =>
      @$el.html @template @model.getRenderContext()
      @
