define [
  "jquery"
  "underscore"
  "backbone"
  "jade.templates"
  "ladda"
  "messenger"
], ($, _, Backbone, jade, Ladda, Messenger) ->
  class AddSocialForm extends Backbone.View
    template: jade.adminAddSocial
    events:
      "click #submit-add-donate": "addDonate"
      "input #input-donate-text": "updateDonateText"
      "input #input-donate-description": "updateDonateDescription"
      "input #input-donate-team-id": "updateDonateTeamId"
    
    initialize: (options) =>

      super

    render: =>
      @$el.html @template()

      @