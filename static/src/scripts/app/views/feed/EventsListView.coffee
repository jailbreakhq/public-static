define [
  'jquery'
  'underscore'
  'backbone'
  'jade.templates'
  'mixen'
  'mixens/CollectionViewMixen'
  'views/feed/DonateView'
  'views/feed/LinkView'
  'views/feed/CheckinView'
], ($, _, Backbone, jade, Mixen, CollectionViewMixen, DonateView, LinkView, CheckinView) ->
  class EventsListView extends Mixen(CollectionViewMixen, Backbone.View)
    template: jade.feedList

    initialize: (options) =>
      @collection = options.collection

      super

    render: =>
      context = @getRenderContext()
      @$el.html @template context

      @renderEvents()

      @

    renderEvents: =>
      htmlList = $('#events-stream-list', @$el)
      for feedEvent in @collection.models
        switch feedEvent.get 'type'
          when 'DONATE'
            donate = feedEvent.get 'donate'
            donate.set 'time', feedEvent.get 'time'
            donateView = new DonateView
              model: donate
            htmlList.append donateView.render().$el
          when 'LINK'
            link = feedEvent.get 'link'
            link.set 'time', feedEvent.get 'time'
            linkView = new LinkView
              model: link
            htmlList.append linkView.render().$el
          when 'CHECKIN'
            checkin = feedEvent.get 'checkin'
            checkinView = new CheckinView
              model: checkin
            htmlList.append checkinView.render().$el