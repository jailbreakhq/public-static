define [
  'backbone'
  'mixen'
  'mixens/EventJanitorMixen'
], (backbone, Mixen, EventJanitorMixen) ->
  class BaseView extends Mixen(EventJanitorMixen, Backbone.View)
    # spooky for now