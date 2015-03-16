define [
  'jquery'
  'underscore'
  'backbone'
  'foundation'
  'foundation.tabs'
  'jade.templates'
  'mixen'
  'mixens/RequiresLoginMixen'
  'collections/TeamsCollection'
  'views/admin/AddLinkFormView'
  'views/admin/AddDonateFormView'
  'views/admin/AddSocialFormView'
], ($, _, Backbone, foundation, tabs, jade, Mixen, RequiresLoginMixen, Teams, AddLinkFormView, AddDonateFormView, AddSocialFormView) ->
  class AdminFeedView extends Mixen(RequiresLoginMixen, Backbone.View)
    template: jade.adminAddFeed

    initialize: (options) ->
      @teams = new Teams
      @teams.fetch()

      super

    render: =>
      super
      
      @$el.html @template()

      $(@$el).foundation() # tabs

      @renderLinkForm()
      @renderDonateForm()
      @renderSocialForm()

      @

    renderLinkForm: ->
      linkFormView = new AddLinkFormView
      $('#links-panel', @$el).html linkFormView.render().$el

    renderDonateForm: ->
      donateFormView = new AddDonateFormView
        teams: @teams
      $('#donate-panel', @$el).html donateFormView.render().$el

    renderSocialForm: ->
      socialFormView = new AddSocialFormView
        teams: @teams
      $('#social-panel', @$el).html socialFormView.render().$el