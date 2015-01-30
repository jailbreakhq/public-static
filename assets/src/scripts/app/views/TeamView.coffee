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
      @render()

    render: =>
      @$el.html(@template())

      _.each @collection.models, (team) =>
        teamView = new TeamItemView
          model: team
        $("#teams").append(teamView.render().$el)

      @