path = require 'path'


module.exports = (grunt) ->
  for key of grunt.file.readJSON('package.json').devDependencies
    if key isnt 'grunt' and key.indexOf('grunt') is 0
      grunt.loadNpmTasks key
  
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    coffee:
      dev:
        options:
          sourceMap: true
        files: [
          expand: true
          cwd: 'app/scripts/'
          src: [ '**/*.coffee' ]
          dest: '.tmp/scripts/'
          ext: '.js'
        ]
      dist:
        options:
          sourceMap: true
        files: [
          expand: true
          cwd: 'app/scripts/'
          src: [ '**/*.coffee' ]
          dest: 'dist/scripts/'
          ext: '.js'
        ]

    less:
      dev:
        options:
          yuicompress: false
        files: [
          expand: true
          cwd: 'app/styles/'
          src: [ '**/*.less' ]
          dest: '.tmp/styles/'
          ext: '.css'
        ]
      dist:
        options:
          yuicompress: true
        files: [
          expand: true
          cwd: 'app/styles/'
          src: [ '**/*.less' ]
          dest: 'dist/styles/'
          ext: '.css'
        ]

    copy:
      dev_html:
        files: [
          expand: true
          dot: true
          cwd: 'app'
          dest: '.tmp'
          src: [
            '*.html'
            'views/*.html'
          ]
        ]
      dev_resources:
        files: [
          expand: true
          dot: true
          cwd: 'app'
          dest: '.tmp'
          src: [
            '*.{ico,png,txt}'
            'bower_components/**/*'
            'images/{,*/}*.{png,jpg,jpeg,gif,webp,svg}'
            'styles/fonts/*'
          ]
        ]
      dist:
        files: [
          expand: true
          dot: true
          cwd: 'app'
          dest: 'dist'
          src: [
            '*.{ico,png,txt}'
            'bower_components/**/*'
            'images/{,*/}*.{gif,webp,svg}'
            'styles/fonts/*'
            '*.html'
            'views/*.html'
          ]
        ]

    cdnify:
      dist:
        html: [ 'dist/*.html' ]

    useminPrepare:
      html: [ 'dist/*.html' ]
      options:
        dest: 'dist/'

    usemin:
      html: [ 'dist/*.html' ]
      options:
        dirs: [ 'dist/' ]

    htmlmin:
      dist:
        options:
          removeCommentsFromCDATA: true
          # https://github.com/yeoman/grunt-usemin/issues/44
          collapseWhitespace: true
          collapseBooleanAttributes: true
          # removeAttributeQuotes: true
          removeRedundantAttributes: true
          useShortDoctype: true
          removeEmptyAttributes: true
          removeOptionalTags: true
        files: [
          expand: true
          cwd: 'dist/'
          src: [ '*.html', 'views/*.html' ]
          dest: 'dist/'
        ]

    imagemin:
      dist:
        files: [
          expand: true
          cwd: 'app/images/'
          src: '{,*/}*.{png,jpg,jpeg}'
          dest: 'dist/images/'
        ]

    express:
      options:
        port: 20020
        hostname: '*'
        cmd: 'coffee'
      dev:
        options:
          script: 'server/index.coffee'
          node_env: 'dev'
      dist:
        options:
          script: 'server/index.coffee'
          node_env: 'dist'
          background: false

    open:
      server:
        url: 'http://localhost:<%= express.options.port %>'

    watch:
      dev_app_scripts:
        files: [ 'app/scripts/*' ]
        tasks: [ 'coffee:dev' ]
      dev_app_styles:
        files: [ 'app/styles/*' ]
        tasks: [ 'less:dev' ]
      dev_app_html:
        files: [ 'app/*.html', 'app/views/*.html' ]
        tasks: [ 'copy:dev_html' ]
      dev_server:
        files: [ 'server/**/*' ]
        tasks: [ 'express:dev:stop', 'express:dev' ]
        options:
          spawn: false

    clean: 
      dev: [ '.tmp/' ]
      dist: [ 'dist/' ]


  grunt.registerTask 'default', [
    'build'
  ]

  grunt.registerTask 'build', [
    'build:dev'
    'build:dist'
  ]

  grunt.registerTask 'build:dev', [
    'clean:dev'
    'coffee:dev'
    'less:dev'
    'copy:dev_html'
    'copy:dev_resources'
  ]

  grunt.registerTask 'build:dist', [
    'clean:dist'
    'coffee:dist'
    'less:dist'
    'copy:dist'
    'useminPrepare'
    'concat'
    'uglify'
    'cssmin'
    'usemin'
    'htmlmin:dist'
    'cdnify'
    'imagemin:dist'
  ]

  grunt.registerTask 'server', [
    'server:dev'
  ]

  grunt.registerTask 'server:dev', [
    'build:dev'
    'express:dev'
    'open'
    'watch'
  ]
  
  grunt.registerTask 'server:dist', [
    'build:dist'
    'express:dist'
  ]
