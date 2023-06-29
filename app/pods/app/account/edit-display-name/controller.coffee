import Controller from '@ember/controller'
import env from 'mutambo-web/config/environment'
import fetch from 'fetch'
import isEmpty from 'lodash/isEmpty'
import isString from 'lodash/isString'
import every from 'lodash/every'
import values from 'lodash/values'
import { action, get, set } from '@ember/object'
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

  validateDisplayName: ->
    dn = get(this, 'form.values.display_name')
    ok = @User.ok.displayName(dn)
    set(this, 'form.valid.display_name', ok)
    return ok

  formKeyPress: action((field, e) ->
    switch field
      when 'display_name'
        this.sendCodeEmail() if (e.code == 'Enter' || e.code == 'NumpadEnter') && this.validateForm()
    return
  )

  formValueChanged: action((field, e) ->
    set(this, "form.values.#{field}", e.target.value)

    switch field
      when 'display_name' then this.validateDisplayName()

    this.validateForm()
    return
  )

  save: action(->
    set(this, 'form.submitted', true)

    if !this.validateForm()
      return

    form = get(this, 'form')

    obj = { display_name: form.values.display_name }
    reply = await this.api.echo({ path: "/v1/user/display-name/update", data: obj })

    await this.User.sync({ force: true }) if reply?
    this.router.transitionTo('app.account')
    return
  )

  toggleHelp: action((field) ->
    set(this, "form.help.#{field}", !get(this, "form.help.#{field}"))
    return
  )


})