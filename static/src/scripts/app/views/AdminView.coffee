define [
  "jquery"
  "underscore"
  "backbone"
  "jade.templates"
  "mixen"
  "mixens/RequiresLoginMixen"
  "views/TeamItemView"
], ($, _, Backbone, jade, Mixen, RequiresLoginMixen, TeamItemView) ->
  class AdminView extends Mixen(RequiresLoginMixen, Backbone.View)
    template: jade.admin

    initialize: (options) ->
      @teams = options.teams
      @.listenTo @teams, "sync", @renderTeams
      @.listenTo @teams, "change", @renderTeams

      super

    render: =>
      super
      
      @$el.html @template()

      @

    renderTeams: =>
      list = $("#teams").empty()

      @teams.sort()

      _.each @teams.models, (team) ->
        teamView = new TeamItemView
          model: team
          template: jade.teamCheckinOverview
          tagName: "tr"
        list.append teamView.render().$el
