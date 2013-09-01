class OpinionBabyHelper

OpinionBabyHelper.parsedToHtml = (parsedObject) ->
  sourceText = parsedObject.sourceText
  positions = parsedObject.positions

  html = ''
  currentSourceTextPosition = 0

  for p in positions
    html += sourceText[currentSourceTextPosition...p.position]
    currentSourceTextPosition = p.position

    switch p.type
      when 'partStart'
        if p.opinion is 'positive'
          if not p.isNot
            opinion = 'positive'
          else
            opinion = 'negative'
        else if p.opinion is 'negative'
          if not p.isNot
            opinion = 'negative'
          else
            opinion = 'positive'

        html += "<span class='opinion #{opinion}'>"

      when 'partEnd'
        html += '</span>'
      when 'wordStart'
        html += '<strong>'
      when 'wordEnd'
        html += '</strong>'

  html += sourceText[currentSourceTextPosition..-1]

  html
