define [
  'jquery'
  'underscore'
  'backbone'
  'jade.templates'
  'mixen'
  'mixens/BaseViewMixen'
  'mixens/CollectionViewMixen'
  'views/feed/DonateView'
  'views/feed/LinkView'
  'views/feed/CheckinView'
], ($, _, Backbone, jade, Mixen, BaseViewMixen, CollectionViewMixen, DonateView, LinkView, CheckinView) ->
  class EventsListView extends Mixen(CollectionViewMixen, BaseViewMixen)
    template: jade.feedList

    render: =>
      context = @getRenderContext()
      @$el.html @template context

      htmlList = $('#events-stream-list', @$el)
      for feedEvent in @collection.models
        switch feedEvent.get 'type'
          when 'DONATE'
            donate = feedEvent.get 'donate'
            donate.set 'time', feedEvent.get 'time'
            donateView = new DonateView
              model: donate
            htmlList.append donateView.render().$el
            @rememberView donateView

          when 'LINK'
            link = feedEvent.get 'link'
            link.set 'time', feedEvent.get 'time'
            linkView = new LinkView
              model: link
            htmlList.append linkView.render().$el
            @rememberView linkView
            
          when 'CHECKIN'
            checkin = feedEvent.get 'checkin'
            checkinView = new CheckinView
              model: checkin
            htmlList.append checkinView.render().$el
            @rememberView checkinView

      @