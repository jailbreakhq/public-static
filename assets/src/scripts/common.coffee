requirejs.config
  baseUrl: "assets/dist/scripts/app"
  paths:
    "jquery": "/assets/components/jquery/dist/jquery",
    "underscore": "/assets/components/underscore/underscore"
    "backbone": "/assets/components/backbone/backbone"
    "jade": "/assets/components/jade/runtime"
    "mixen": "/assets/components/mixen/mixen.min"
    "jade.templates": "/assets/dist/templates/jade"
    "foundation": "/assets/dist/scripts/foundation"

  shim:
    foundation:
      deps: [
        "jquery"
      ]

    backbone:
      deps: [
        "jquery"
        "underscore"
      ]