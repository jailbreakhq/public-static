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
    filters: null

    url: =>
      if @filters
        encodedFilters = encodeURIComponent JSON.stringify @filters
        jailbreak.api_host + "/donations?filters=" + encodedFilters
      else
        jailbreak.api_host + "/donations"

    initialize: (data, options) ->
      if options
        @filters = options.filters