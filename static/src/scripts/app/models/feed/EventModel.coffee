define [
  'mixen'
  'mixens/BaseModelMixen'
  'models/feed/DonateEventModel'
  'models/feed/LinkEventModel'
  'models/CheckinModel'
], (Mixen, BaseModelMixen, DonateEvent, LinkEvent, Checkin) ->
  class Event extends Mixen(BaseModelMixen)
    initialize: (options) ->
      super

    url: ->
      jailbreak.api_host + '/events'

    parse: (response) ->
      switch response.type
        when 'DONATE'
          response.donate = new DonateEvent response.donate,
            parse: true
        when 'LINK'
          response.link = new LinkEvent response.link,
            parse: true
        when 'CHECKIN'
          response.checkin = new Checkin response.checkin,
            parse: true

      response

    getRenderContext: ->
      context = @.toJSON()
      switch @.get 'type'
        when 'DONATE'
          context.donate = @get('donate').getRenderContext()
        when 'LINK'
          context.link = @get('link').getRenderContext()
        when 'CHECKIN'
          context.checkin = @get('checkin').getRenderContext()

      context