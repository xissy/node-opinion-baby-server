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
      dev:
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
            '*.html'
            'views/*.html'
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
        port: 20000
        hostname: '*'
        server: 'server'
      dev:
        options:
          bases: [ '.tmp' ]
          livereload: true
          serverreload: true
      dist:
        options:
          bases: [ 'dist' ]

    open:
      server:
        url: 'http://localhost:<%= express.options.port %>'

    clean: 
      server: [ 'server/js/' ]
      dev: [ '.tmp/' ]
      dist: [ 'dist/' ]


  grunt.registerTask 'default', [
    'coffee'
  ]

  grunt.registerTask 'server', [
    'clean:dev'
    'coffee:dev'
    'less:dev'
    'copy:dev'
    'express:dev'
  ]
  
  grunt.registerTask 'server:dist', [
    'clean:dist'
    'coffee:dist'
    'less:dist'
    'copy:dist'
    # 'cdnify'
    'useminPrepare'
    'concat'
    'uglify'
    'cssmin'
    'usemin'
    'htmlmin:dist'
    'imagemin:dist'
    'express:dist'
    'express-keepalive'
  ]
