define [
  "jquery"
  "underscore"
  "backbone"
  "jade.templates"
  "models/TeamModel"
], ($, _, Backbone, jade, Team) ->
  class TeamProfile extends Backbone.View
    template: jade.team

    initialize: (options) =>
      @model = new Team
        id: options.teamId
      @model.bind "change", @render
      @model.fetch
        success: @render

    render: =>
      @$el.html @template @model.toJSON()

      @