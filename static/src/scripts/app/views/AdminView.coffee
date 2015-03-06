define [
  "jquery"
  "underscore"
  "backbone"
  "jade.templates"
  "mixen"
  "mixens/RequiresLoginMixen"
  "views/TeamItemView"
  "views/AddCheckinView"
  "vex"
], ($, _, Backbone, jade, Mixen, RequiresLoginMixen, TeamItemView, AddCheckinView, vex) ->
  class AdminView extends Mixen(RequiresLoginMixen, Backbone.View)
    template: jade.admin
    events:
      "click .add-checkin": "addCheckin"

    initialize: (options) ->
      @teams = options.teams
      @.listenTo @teams, "sync", @renderTeams

      super

    render: =>
      super
      
      @$el.html @template()

      @

    renderTeams: =>
      list = $("#teams")

      _.each @teams.models, (team) ->
        teamView = new TeamItemView
          model: team
          template: jade.teamCheckinOverview
          tagName: "tr"
        list.append teamView.render().$el

    addCheckin: (event) ->
      addCheckinView = new AddCheckinView
        teamId: $(event.target).data "team-id"
        parent: @

      vex.defaultOptions.className = 'vex-theme-default'
      $vexContent = vex.open
        content: addCheckinView.render().$el
        afterOpen: ($vexContent) ->
          $vexContent.append.$el

      @vexId = $vexContent.data().vex.id

    closeVex: =>
      vex.close @vexId
