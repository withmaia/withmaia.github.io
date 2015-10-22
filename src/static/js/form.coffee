$ = require 'jquery'

success_message = 'Thanks! We will send updates when new devices and tutorials are released.'

showSuccess = ($form) ->
    p = $("<p class='note'>#{ success_message }</p>")
    $form.after p
    $form.slideUp()

form_error = ($form) ->
    $form.find('input').addClass('has-error').focus()

$ ->

    $('.email-form').on 'submit', (e) ->
        e.preventDefault()
        e.stopPropagation()

        $form = $(e.currentTarget)

        $form.find('input').removeClass 'has-error'

        val = $form.find('input').val()

        email_match = RegExp '\\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,4}\\b', 'i'
        if (!val.match(email_match))
            form_error($form)

        else
            $.post 'http://api.withmaia.io/subscribe.json', {email: val}, (data) ->
                showSuccess($form)

