'use strict';

var fs = require('fs'),
  path = require('path');

function basename(str) {
  var base = String(str).substring(str.lastIndexOf('/') + 1);
  if (base.lastIndexOf(".") !== -1) {
    base = base.substring(0, base.lastIndexOf("."));
  }
  return base;
}

function countryName(str) {
  var base = String(str).substring(str.lastIndexOf('/') + 1);
  base = base.substring(0, base.lastIndexOf("data") - 1);
  base = base.replace(/_/g, ' ');
  return base;
}

function dirTree(filename) {
  var stats = fs.lstatSync(filename),
    info = {
      path: filename,
      name: path.basename(filename),
      shortName: basename(filename),
      countryName: countryName(filename)
    };

  if (stats.isDirectory()) {
    info.type = "folder";
    info.children = [];

    var dirResults = fs.readdirSync(filename);

    dirResults.forEach(function (child) {
      if (path.basename(filename + '/' + child) !== '.DS_Store') {
        info["children"].push(dirTree(filename + '/' + child));
      }
    });
  } else {
    info.type = "file";
  }

  return info;
}

module.exports = function (grunt) {
  grunt.registerMultiTask('dir2json', 'Builds a json file based on directory structure', function () {

    // Iterate over all specified file groups.
    this.files.forEach(function (file) {
      // Concat specified files.
      var src = file.src.filter(function (filepath) {
        // Warn on and remove invalid source files (if nonull was set).
        if (!grunt.file.exists(filepath)) {
          grunt.log.warn('Source file "' + filepath + '" not found.');
          return false;
        } else {
          return true;
        }
      }).map(function (filepath) {
        return dirTree(filepath);
      });

      grunt.file.write(file.dest, JSON.stringify(src, null, 2));

      grunt.log.writeln('File "' + file.dest + '" created.');
    });
  });

};
