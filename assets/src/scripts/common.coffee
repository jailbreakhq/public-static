requirejs.config
  baseUrl: "assets/"
  paths:
    "jquery": "components/jquery/dist/jquery",
    "underscore": "components/underscore/underscore"
    "backbone": "components/backbone/backbone"
    "jade": "components/jade/runtime"
    "jade.templates": "dist/templates/jade"

  shim:
    backbone:
      deps: [
        "jquery"
        "underscore"
        "jade"
      ]