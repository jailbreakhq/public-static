define [
  "jquery"
  "underscore"
  "backbone"
  "jade.templates"
], ($, _, Backbone, jade) ->
  class TeamCardView extends Backbone.View
    template: jade.teamCard
    
    initialize: =>
      if options.template
        @template = options.template
      @model.bind "change", @render

    render: =>
      @$el.html @template @model.getRenderContext()
      @
