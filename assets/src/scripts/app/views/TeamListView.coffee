define [
  "jquery"
  "underscore"
  "backbone"
  "jade.templates"
  "collections/TeamsCollection"
  "views/TeamItemView"
], ($, _, Backbone, jade, Teams, TeamItemView) ->
  class TeamList extends Backbone.View
    template: jade.teams

    initialize: (options) =>
      if not options.collection
        new Error("DonationsList view needs a collection in it's options")
      @collection = options.collection

    render: =>
      @$el.html @template()

      _.each @collection.models, (team) ->
        teamView = new TeamItemView
          model: team
        $("#teams").append teamView.render().$el

      @