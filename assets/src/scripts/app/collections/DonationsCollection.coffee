define [
  "jquery"
  "underscore"
  "backbone"
  "mixen"
  "mixens/AuthMixen"
  "models/DonationModel"
], ($, _, Backbone, Mixen, AuthMixen, Donation) ->
  class Donations extends Mixen(AuthMixen, Backbone.Collection)
    model: Donation
    filters: {}
    url: =>
      if @filters
        jailbreak.api_host + "/donations?filters=" + encodeURIComponent JSON.stringify @filters
      else
        jailbreak.api_host + "/donations"

    initialize: (data, options) ->
      @filters = options.filters