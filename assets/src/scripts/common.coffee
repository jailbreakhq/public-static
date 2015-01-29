requirejs.config
  baseUrl: "assets/"
  paths:
    "jquery": "components/jquery/dist/jquery",
    "underscore": "components/underscore/underscore"
    "backbone": "components/backbone/backbone"
    "jade": "components/jade/runtime"
    "jade.templates": "dist/templates/jade"
    "foundation": "dist/scripts/foundation"
    "odometer": "components/odometer/odometer.min"

  shim:
    foundation:
      deps: [
        "jquery"
      ]

    backbone:
      deps: [
        "jquery"
        "underscore"
        "jade"
        "foundation"
      ]