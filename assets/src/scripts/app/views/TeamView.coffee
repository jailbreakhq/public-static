define [
  "jquery"
  "underscore"
  "backbone"
  "jade.templates"
  "models/TeamModel"
], ($, _, Backbone, jade, Team) ->
  class Team extends Backbone.View
    template: jade.team

    initialize: =>
      @model.bind("change", @render)

    render: =>
      @$el.html(@template(@model.toJSON()))
      @