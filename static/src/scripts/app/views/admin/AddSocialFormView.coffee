define [
  "jquery"
  "underscore"
  "backbone"
  "jade.templates"
  "models/feed/DonateEventModel"
  "views/feed/DonateView"
  "ladda"
  "messenger"
], ($, _, Backbone, jade, DonateEvent, DonateView, Ladda, Messenger) ->
  class AddSocialForm extends Backbone.View
    template: jade.adminAddDonate
    events:
      "click #submit-add-donate": "addDonate"
      "input #input-donate-text": "updateDonateText"
      "input #input-donate-description": "updateDonateDescription"
      "input #input-donate-team-id": "updateDonateTeamId"
    
    initialize: (options) =>
      @model = new DonateEvent

      @.listenTo @model, "change", @renderPreview

      super

    render: =>
      @$el.html @template()

      @

    renderPreview: (event) ->
      console.log 'render preview'
      donatePreview = new DonateView
        model: @model
      $("#donate-preview", @$el).html donatePreview.render().$el

    updateDonateText: (event) ->
      @model.set 'linkText', $("#input-link-text", @$el).val()

    updateDonateDescription: (event) ->
      @model.set 'description', $("#input-link-description", @$el).val()

    updateDonateTeamId: (event) ->
      @model.set 'temId', $("#input-donate-team-id", @$el).val()

    addLink: (event) ->
      event.preventDefault()

      data =
        linkText: $("#input-donate-text", @$el).val()
        description: $("#input-donate-description", @$el).val()
        teamId: $("#input-donate-team-id", @$el).val()

      l = Ladda.create document.getElementById "submit-add-donate"
      l.start()

      valid = true
      if not @checkField data.url, "#input-donate-url"
        valid = false

      if not @checkField data.linkText, "#input-donate-text"
        valid = false

      if not @checkField data.description, "#input-donate-description"
        valid = false

      if not valid
        $("form", @$el).animo
          animation: "shake-subtle"
          duration: 0.5
        l.stop()
        return false

      @model.save {},
        success: (model, response) ->
          Messenger().post "Donate button added to news feed"
          l.stop()
        error: (model, error) =>
          Messenger().post
            message: "There was a problem. Talk to Kevin. " + error.message
            type: "error"
            showCloseButton: true
          l.stop()
          $("form", @$el).animo
            animation: "shake-subtle"
            duration: 0.5

    checkField: (value, selector) ->
      if not value
        $(selector, @$el).addClass "error-field"
        return false
      else
        $(selector, @$el).removeClass "error-field"
        return true
