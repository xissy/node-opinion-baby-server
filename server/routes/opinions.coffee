opinionBaby = require 'opinion-baby'


exports.parse = parse = (req, res) ->
  sourceText = req.body.sourceText

  opinionBaby.parse sourceText, (err, result) ->
    return res.send 500, err.message  if err?

    res.json result
