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

  formKeyPress: action((field, selection, e) ->
    set(this, 'form.values.gender', selection)
    return
  )

  formValueChanged: action((field, selection, e) ->
    set(this, 'form.values.gender', selection)
    this.validateForm()
    return
  )

  save: action(->
    set(this, 'form.submitted', true)

    if !this.validateForm()
      return

    form = get(this, 'form')

    obj = { gender: form.values.gender }
    reply = await this.api.echo({ path: "/v1/user/gender/update", data: obj })

    await this.User.sync({ force: true }) if reply?
    this.router.transitionTo('app.account')
    return
  )

  toggleHelp: action((field) ->
    set(this, "form.help.#{field}", !get(this, "form.help.#{field}"))
    return
  )


})