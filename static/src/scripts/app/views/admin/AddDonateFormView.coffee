define [
  'jquery'
  'underscore'
  'backbone'
  'jade.templates'
  'models/TeamModel'
  'models/feed/DonateEventModel'
  'views/feed/DonateView'
  'ladda'
  'messenger'
  'select2'
], ($, _, Backbone, jade, Team, DonateEvent, DonateView, Ladda, Messenger, Select2) ->
  class AddSocialForm extends Backbone.View
    template: jade.adminAddDonate
    events:
      'click #submit-add-donate': 'addDonate'
      'input #input-donate-text': 'updateDonateText'
      'input #input-donate-description': 'updateDonateDescription'
    
    initialize: (options) =>
      @teams = options.teams
      @model = new DonateEvent

      @.listenTo @model, 'change', @renderPreview
      @.listenTo @teams, 'sync', @render

      super

    render: =>
      teamsContext = _.map @teams.models, (val) -> val.getRenderContext()

      context =
        teams: teamsContext
      @$el.html @template context

      $('select', @$el).select2().on('change', @updateDonateTeamId)

      @

    renderPreview: (event) ->
      donatePreview = new DonateView
        model: @model
      $('#donate-preview', @$el).html donatePreview.render().$el

    updateDonateText: (event) ->
      @model.set 'linkText', $('#input-donate-text', @$el).val()

    updateDonateDescription: (event) ->
      @model.set 'description', $('#input-donate-description', @$el).val()

    updateDonateTeamId: (event) =>
      team = new Team
        id: event.val
      team.fetch
        success: (model, response) =>
          @model.set 'team', model

      @model.set 'teamId', event.val

    addDonate: (event) ->
      event.preventDefault()

      data =
        linkText: $('#input-donate-text', @$el).val()
        description: $('#input-donate-description', @$el).val()
        teamId: $('#input-donate-team-id', @$el).val() or null

      l = Ladda.create document.getElementById 'submit-add-donate'
      l.start()

      valid = true
      if not @checkField data.linkText, '#input-donate-text'
        valid = false

      if not @checkField data.description, '#input-donate-description'
        valid = false

      if not valid
        $('form', @$el).animo
          animation: 'shake-subtle'
          duration: 0.5
        l.stop()
        return false

      @model.save {},
        success: (model, response) ->
          Messenger().post 'Donate button added to news feed'
          l.stop()
        error: (model, error) =>
          Messenger().post
            message: 'There was a problem. Talk to Kevin. ' + error.message
            type: 'error'
            showCloseButton: true
          l.stop()
          $('form', @$el).animo
            animation: 'shake-subtle'
            duration: 0.5

    checkField: (value, selector) ->
      if not value
        $(selector, @$el).addClass 'error-field'
        return false
      else
        $(selector, @$el).removeClass 'error-field'
        return true
