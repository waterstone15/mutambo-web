import Controller from '@ember/controller'
import env from 'mutambo-web/config/environment'
import fetch from 'fetch'
import isEmail from 'validator/lib/isEmail'
import isString from 'lodash/isString'
import every from 'lodash/every'
import values from 'lodash/values'
import { action, get, set } from '@ember/object'
import { inject } from '@ember/service'

export default Controller.extend({

  next: null
  notice: null
  queryParams: [ 'next', 'notice', ]
  router: inject()

  validateForm: ->
    formOk = every(values(get(this, 'form.valid')))
    set(this, 'form.ok', formOk)
    return formOk

  validateEmail: ->
    email = get(this, 'form.values.email')
    emailOk = isString(email) && isEmail(email)
    set(this, 'form.valid.email', emailOk)
    return emailOk

  formKeyPress: action((field, e) ->
    switch field
      when 'email'
        this.sendCodeEmail() if (e.code == 'Enter' || e.code == 'NumpadEnter') && this.validateForm()
    return
  )

  formValueChanged: action((field, e) ->
    set(this, "form.values.#{field}", e.target.value)

    switch field
      when 'email' then this.validateEmail()

    this.validateForm()
    return
  )

  sendCodeEmail: action(->
    set(this, 'form.submitted', true)

    if !this.validateForm()
      return

    form = get(this, 'form')
    try
      data = { email: form.values.email }
      data.next = get(this, 'next') if !!get(this, 'next')

      res = await fetch("#{env.app.apiUrl}/v1/auth/send-code-link", {
        body:    JSON.stringify(data)
        headers: 'Content-Type': 'application/json'
        method:  'POST'
      })
      data = await res.json()
      this.router.transitionTo('sign-in-await')
    catch e
      console.log e

    return
  )

  toggleHelp: action((field) ->
    set(this, "form.help.#{field}", !get(this, "form.help.#{field}"))
    return
  )


})