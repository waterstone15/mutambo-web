import Controller from '@ember/controller'
import env from 'mutambo-web/config/environment'
import every from 'lodash/every'
import fetch from 'fetch'
import isEmpty from 'lodash/isEmpty'
import isString from 'lodash/isString'
import values from 'lodash/values'
import { action, get, set } from '@ember/object'
import { DateTime } from 'luxon'
import { inject as I } from '@ember/service'

export default Controller.extend({

  api:    I('api')
  fb:     I('fb-init')
  router: I('router')

  User:   I('models/user')

  validateForm: ->
    ok = every(values(get(this, 'form.valid')))
    set(this, 'form.ok', ok)
    return ok

  validateAddress: ->
    address = get(this, 'form.values.address')
    ok = @User.ok.address(address)
    set(this, 'form.valid.address', ok)
    return ok

  formKeyPress: action((field, e) ->
    return
  )

  formValueChanged: action((field, e) ->
    set(this, "form.values.#{field}", e.target.value)

    switch field
      when 'address' then this.validateAddress()

    this.validateForm()
    return
  )

  save: action(->
    set(this, 'form.submitted', true)

    if !this.validateForm()
      return

    form = get(this, 'form')

    obj = { address: form.values.address }
    reply = await this.api.echo({ path: "/v1/user/address/update", data: obj })

    await this.User.sync({ force: true }) if reply?
    this.router.transitionTo('app.account')
    return
  )

  toggleHelp: action((field) ->
    set(this, "form.help.#{field}", !get(this, "form.help.#{field}"))
    return
  )


})