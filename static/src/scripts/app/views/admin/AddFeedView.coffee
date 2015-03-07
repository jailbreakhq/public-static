define [
  "jquery"
  "underscore"
  "backbone"
  "foundation"
  "foundation.tabs"
  "jade.templates"
  "mixen"
  "mixens/RequiresLoginMixen"
  "views/admin/AddLinkFormView"
], ($, _, Backbone, foundation, tabs, jade, Mixen, RequiresLoginMixen, AddLinkFormView) ->
  class AdminFeedView extends Mixen(RequiresLoginMixen, Backbone.View)
    template: jade.adminAddFeed

    initialize: (options) ->
      super

    render: =>
      super
      
      @$el.html @template()

      $(@$el).foundation() # tabs

      @renderLinkForm()

      @

    renderLinkForm: ->
      linkFormView = new AddLinkFormView
      $("#links-panel", @$el).html linkFormView.render().$el