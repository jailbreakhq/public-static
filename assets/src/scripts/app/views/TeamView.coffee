define [
  "jquery"
  "underscore"
  "backbone"
  "jade.templates"
], ($, _, Backbone, jade) ->
  class TeamView extends Backbone.View
    tagName: "li"
    template: jade.team
    
    initialize: =>
      @model.bind("change", @render)

    render: =>
      @$el.html(@template(@model.toJSON()))
      @