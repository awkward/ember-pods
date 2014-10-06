########################
# Compile and concatenate *.styl files
########################

# shorthand method to get all the required *.styl files
importsCssBundle = (grunt) ->
  imports = grunt.file.expand({cwd: "app/assets/stylesheets/imports/"}, '**/*.styl')
  imports.push('nib')
  return imports

module.exports = (grunt) ->
  stylus:
    compile:
      options:
        paths: ['app/assets/stylesheets/imports']
        import: importsCssBundle(grunt)
      files:
        'tmp/build/stylesheets/main.css':[
          'app/assets/stylesheets/main.styl'
          'app/pods/**/*.styl'
          'app/components/**/*.styl'
        ]