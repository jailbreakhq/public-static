define [
  'jquery'
  'underscore'
  'backbone'
  'mixen'
  'mixens/FilterableCollectionMixen'
  'mixens/BaseCollectionMixen'
  'models/TeamModel'
], ($, _, Backbone, Mixen, FilterableCollectionMixen, BaseCollectionMixen, Team) ->
  class Teams extends Mixen(FilterableCollectionMixen, BaseCollectionMixen)
    model: Team
    urlPath: '/teams'