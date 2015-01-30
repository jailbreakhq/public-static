define [
  "jquery"
  "underscore"
  "backbone"
  "jade.templates"
], ($, _, Backbone, jade) ->
  class TeamItem extends Backbone.View
    tagName: "li"
    template: jade.teamListItem
    
    initialize: =>
      @model.bind("change", @render)

    render: =>
      @$el.html(@template(@model.toJSON()))
      @
