module.exports = (grunt) ->
  
  # Project configuration
  grunt.initConfig
    pkg: grunt.file.readJSON("package.json")

    paths:
      static: "static"
      build: "static/build"
      src: "static/src"
      deploy: "static/dist"
      components: "static/components"
      html: "static/html"
    
    # Coffeescript Linter
    coffeelint:
      tests:
        files:
          src: ["<%= paths.src %>/scripts/**/*.coffee"]
      options:
        configFile: "coffeelint.json"

    # CoffeeScript
    coffee:
      options:
        sourceMap: false
        sourceRoot: ""

      glob_to_multiple:
        expand: true,
        flatten: false,
        cwd: "<%= paths.src %>/scripts/",
        src: ["**/*.coffee"],
        dest: "<%= paths.build %>/scripts/",
        ext: ".js"
    
    # Compile Sass to CSS -  destination : source
    sass:
      build:
        options:
          style: "compressed"
          sourceComments: "normal"

        files:
          "<%= paths.build %>/styles/main.css": "<%= paths.src %>/styles/main.sass"
          "<%= paths.build %>/styles/iframe.css": "<%= paths.src %>/styles/iframe.sass"

    # Compile Jade files
    jade:
      compile:
        options:
          client: true
          namespace: "jade.templates"
          amd: true
          processName: (filename) ->
            name = filename.replace ".jade", ""
            name = name.replace "static/src/templates/", ""
            name = name.replace "/", "."
            return name
          data:
            debug: false
        files:
          "<%= paths.build %>/templates/jade.js": ["<%= paths.src %>/templates/**/*.jade"]

    ##
    ## Deployment Configuration
    ##
    requirejs:
      compile: 
        options: 
          baseUrl: "<%= paths.build %>/scripts/app"
          mainConfigFile: "<%= paths.build %>/scripts/common.js"
          name: "main"
          out: "<%= paths.deploy %>/scripts/main.js"

    cssmin:
      deploy:
        files:
          "<%= paths.deploy %>/styles/main.css": "<%= paths.build %>/styles/main.css"
          "<%= paths.deploy %>/styles/iframe.css": "<%= paths.build %>/styles/iframe.css"

    uglify:
      deploy:
        files:
          "<%= paths.deploy %>/scripts/require.js": ["<%= paths.components %>/requirejs/require.js"]
          "<%= paths.deploy %>/scripts/main.js": ["<%= paths.deploy %>/scripts/main.js"]
          "<%= paths.deploy %>/scripts/iframe.js": ["<%= paths.deploy %>/scripts/iframe.js"]
    
    targethtml:
      dev:
        files:
          "<%= paths.static %>/index.html": "<%= paths.html %>/index.html"
          "<%= paths.static %>/iframe.html": "<%= paths.html %>/iframe.html"
      qa:
        options:
          curlyTags: 
            build: "static-" + (process.env.TRAVIS_BUILD_NUMBER or "local")
        files:
          "<%= paths.static %>/index.html": "<%= paths.html %>/index.html"
          "<%= paths.static %>/iframe.html": "<%= paths.html %>/iframe.html"
      prod:
        options:
          curlyTags: 
            build: "static-" + (process.env.TRAVIS_BUILD_NUMBER or "local")
        files:
          "<%= paths.static %>/index.html": "<%= paths.html %>/index.html"
          "<%= paths.static %>/iframe.html": "<%= paths.html %>/iframe.html"

    ##
    ## Watcher Configuation
    ##
    # Simple config to run sass, and coffee any time a js or sass file is added, modified or deleted
    watch:
      coffee:
        files: ["<%= paths.src %>/scripts/**/*.coffee"]
        tasks: ["coffeelint", "coffee"]

      sass:
        files: ["<%= paths.src %>/styles/**/*.scss", "<%= paths.src %>/styles/**/*.sass"]
        tasks: ["sass:build"]

      jade:
        files: ["<%= paths.src %>/templates/**/*.jade"]
        tasks: ["jade"]

      html:
        files: ["<%= paths.html %>/*.html"]
        tasks: ["targethtml:dev"]

    concurrent:
      build: ["coffee", "sass:build", "jade", "targethtml:dev"]

  # Load the plug-ins
  require("load-grunt-tasks") grunt
  
  # Default tasks
  grunt.registerTask "default", ["concurrent:build"]
  grunt.registerTask "deploy", ["concurrent:build", "requirejs", "cssmin:deploy", "uglify:deploy", "targethtml:qa"]
  grunt.registerTask "deploy:prod", ["concurrent:build", "requirejs", "cssmin:deploy", "uglify:deploy", "targethtml:prod"]
