define [
  'jquery'
  'underscore'
  'backbone'
  'jade.templates'
  'models/feed/LinkEventModel'
  'views/feed/LinkView'
  'ladda'
  'messenger'
], ($, _, Backbone, jade, LinkEvent, LinkView, Ladda, Messenger) ->
  class AddLinkForm extends Backbone.View
    template: jade.adminAddLink
    events:
      'click #submit-add-link': 'addLink'
      'input #input-link-url': 'updateLinkUrl'
      'input #input-link-text': 'updateLinkText'
      'input #input-link-description': 'updateLinkDescription'
      'input #input-link-photo-url': 'updateLinkPhotoUrl'
    
    initialize: (options) =>
      @link = new LinkEvent

      @.listenTo @link, 'change', @renderPreview

      super

    render: =>
      @$el.html @template()

      @

    renderPreview: (event) ->
      linkPreview = new LinkView
        model: @link
      $('#link-preview', @$el).html linkPreview.render().$el

    updateLinkUrl: (event) ->
      @link.set 'url', $('#input-link-url', @$el).val()

    updateLinkText: (event) ->
      @link.set 'linkText', $('#input-link-text', @$el).val()

    updateLinkDescription: (event) ->
      @link.set 'description', $('#input-link-description', @$el).val()

    updateLinkPhotoUrl: (event) ->
      @link.set 'photoUrl', $('#input-link-photo-url', @$el).val()

    addLink: (event) ->
      event.preventDefault()

      data =
        url: $('#input-link-url', @$el).val()
        linkText: $('#input-link-text', @$el).val()
        description: $('#input-link-description', @$el).val()
        photoUrl: $('#input-link-photo-url', @$el).val()

      l = Ladda.create document.getElementById 'submit-add-link'
      l.start()

      valid = true
      if not @checkField data.url, '#input-link-url'
        valid = false

      if not @checkField data.linkText, '#input-link-text'
        valid = false

      if not @checkField data.description, '#input-link-description'
        valid = false

      if not valid
        $('form', @$el).animo
          animation: 'shake-subtle'
          duration: 0.5
        l.stop()
        return false

      @link.save {},
        success: (model, response) ->
          Messenger().post 'Link posted to news feed'
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
