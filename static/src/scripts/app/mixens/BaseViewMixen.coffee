define [
  'jquery'
  'underscore'
  'backbone'
  'mixen'
  'mixens/EventJanitorMixen'
], ($, _, backbone, Mixen, EventJanitorMixen) ->
  class BaseView extends Mixen(EventJanitorMixen, Backbone.View)
    # spooky for now