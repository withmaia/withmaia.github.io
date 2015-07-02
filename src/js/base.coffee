flyd = require 'flyd'
takeUntil = require 'flyd-takeuntil'
render = require '../../../../src/render'
h = require 'virtual-dom/h'

# Outputs
# ------------------------------------------------------------------------------

sequence = (l, t=2000) ->
    i = 0
    s$ = flyd.stream()
    setNext = ->
        if i < l.length
            s$ l[i++]
            setTimeout setNext, t
    setNext()
    return s$

interruptable = (s$) ->
    i$ = flyd.stream()
    si$ = flyd.merge i$, takeUntil s$, i$
    return [si$, i$]

word_colors =
    build: '#779'
    work: '#45c'
    play: '#924'
    live: '#582'
words = Object.keys(word_colors)

[i$, seti$] = interruptable sequence [0..words.length-1]
word$ = i$.map (i) -> words[i]
color$ = word$.map (w) -> word_colors[w]

# App State
# ------------------------------------------------------------------------------

app$ = flyd.stream [i$, word$, color$], ->
    i: i$()
    word: word$()
    color: color$()

# Components
# ------------------------------------------------------------------------------

App = (app) ->
    backgroundColor = app.color
    h '#app', {style: {backgroundColor}}, [
        h 'h1', [
            Words app
            h 'span.withmaia', 'with maia'
        ]
    ]

Words = (app) ->
    bottom = 1.2*(app.i-((words.length-1)/2)) + 'em'
    h '.words', {style: {bottom}}, words.map (w, i) -> Word w, i, app

Word = (word, i, app) ->
    onclick = -> seti$ i
    className = if app.word == word then '.selected' else ''
    h 'a' + className, {onclick}, word

# Going
# ------------------------------------------------------------------------------

render App, app$, document.body

