import Controller from '@ember/controller'
import every from 'lodash/every'
import values from 'lodash/values'
import { action } from '@ember/object'
import { get as eget } from '@ember/object'
import { set as eset } from '@ember/object'
import { DateTime } from 'luxon'
import { inject as I } from '@ember/service'

export default Controller.extend({

  api:    I('api')
  fb:     I('fb-init')
  router: I('router')

  User:   I('models/user')

  validateForm: ->
    ok = (every (values (eget @, 'form.valid')))
    (eset @, 'form.ok', ok)
    return ok

  validateFullName: ->
    val = (eget @, 'form.values.full_name')
    ok  = @.User.ok.fullName(val)
    (eset @, 'form.valid.full_name', ok)
    return ok

  formKeyPress: (action (field, e) ->
    return
  )

  formValueChanged: (action (field, e) ->
    (eset @, "form.values.#{field}", e.target.value)

    switch field
      when 'full_name' then @.validateFullName()

    @.validateForm()
    return
  )

  save: (action ->
    (eset @, 'form.submitted', true)

    if !@.validateForm()
      return

    form = (eget @, 'form')

    obj = { full_name: form.values.full_name }
    reply = await (@.api.echo {
      data: obj
      path: "/v2/user/full-name/update"
    })

    await (@.User.sync { force: true }) if reply?
    (@.router.transitionTo 'app.account')
    return
  )

  toggleHelp: (action (field) ->
    (eset @, "form.help.#{field}", !(eget @, "form.help.#{field}"))
    return
  )


})