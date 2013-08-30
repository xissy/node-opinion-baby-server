opinionBaby = require 'opinion-baby'


exports.parse = parse = (req, res) ->
  res.json
    parse: 'parse'
