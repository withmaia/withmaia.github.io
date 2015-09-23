$ = require 'jquery'

success_message = 'Thanks! We will send updates when new devices and tutorials are released.'

showSuccess = (e) ->
    $form = $(e.currentTarget)
    p = $("<p class='note'>#{ success_message }</p>")
    $form.after p
    $form.slideUp()

form_error = (e) =>
    $('input').addClass('has-error').focus()

$ ->

    $('.email-form').on 'submit', (e) ->
        e.preventDefault()
        e.stopPropagation()

        $('input').removeClass 'has-error'

        val = $('input').val()

        email_match = RegExp '\\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,4}\\b', 'i'
        if (!val.match(email_match))
            form_error()
        else
            $.post '/contact', {email: val}, (data) =>
                showSuccess(e)