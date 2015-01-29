define [
  "jquery"
  "underscore"
  "backbone"
  "jade.templates"
], ($, _, Backbone, jade) ->
  
  $ ->

    class Team extends Backbone.Model
      urlRoot: jailbreak.api_host + "/teams"
      defaults:
        avatar: "https://s3-eu-west-1.amazonaws.com/jailbreak15-qa-uploads/jb-default-avatar"


    class Teams extends Backbone.Collection
      model: Team
      url: jailbreak.api_host + "/teams"


    class TeamView extends Backbone.View
      tagName: "li"
      template: jade.team
      
      initialize: =>
        @model.bind("change", @render)

      render: =>
        @$el.html(@template(@model.toJSON()))
        @


    class TeamListView extends Backbone.View
      template: jade.teams

      initialize: =>
        @collection = new Teams()
        @collection.on("reset", @render)
        @collection.fetch
          success: @render

        @render()

      render: =>
        @$el.html(@template())

        _.each @collection.models, (team) =>
          teamView = new TeamView
            model: team
          $("#teams").append(teamView.render().$el)

        @


    class AppView extends Backbone.View
      el_tag = "#body-container"
      el: $(el_tag)

      template: jade.main

      initialize: =>
        @teamListview = new TeamListView()
        @render()

      render: =>
        $("#body-container").html(@template())

        @$el.append(@teamListview.render().$el)
        @

    $(document).foundation();
    app = new AppView()
