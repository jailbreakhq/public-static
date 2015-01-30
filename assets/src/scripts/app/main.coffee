require [
  "jquery"
  "underscore"
  "backbone"
  "foundation"
  "views/MainView"
], ($, _, Backbone, foundation, MainView) ->
  
  $ ->
    $(document).foundation()
    app = new MainView()
