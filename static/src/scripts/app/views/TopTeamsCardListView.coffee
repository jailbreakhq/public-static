define [
  "jquery"
  "underscore"
  "backbone"
  "jade.templates"
  "views/TeamsCardView"
], ($, _, Backbone, jade, TeamsCardView) ->
  class TopTeamsCardListView extends Backbone.View

    initialize: (options) =>
      if not options.collection
        new Error("TopTeamsCardListView needs a collection in it's options")
      @collection = options.collection

    render: =>
      top = _.first @collection.models, 2
      _.each top, (team) ->
        teamCardView = new TeamsCardView
          model: team
        $("#leaders").append teamCardView.render().$el

      @
