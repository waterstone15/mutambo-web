import * as lz from 'lz-string'
import cloneDeep from 'lodash/cloneDeep'
import Controller from '@ember/controller'
import every from 'lodash/every'
import isString from 'lodash/isString'
import values from 'lodash/values'
import padStart from 'lodash/padStart'
import { action } from '@ember/object'
import { computed } from '@ember/object'
import { get as eget } from '@ember/object'
import { set as eset } from '@ember/object'
import { all } from 'rsvp'
import { inject as I } from '@ember/service'
import { DateTime } from 'luxon'

export default Controller.extend({

  api:    I()
  router: I()

  User:          I('models/user')
  Registrations: I('models/registrations')

  title_string: (computed 'model.itp.val.team.val.name', ->
    tn = (eget @, 'model.itp.val.team.val.name')
    title = tn + ' → Manager Registration - Mutambo'
    return title
  )

  validateForm: ->
    formOk = (every (values (eget @, 'form.valid')))
    (eset @, 'form.ok', formOk)
    return formOk

  validateAddress: ->
    val = (eget @, 'form.values.address')
    ok  = (@.User.ok.address val)
    (eset @, 'form.valid.address', ok)
    return ok

  validateBirthday: ->
    val = (eget @, 'form.values.birthday')
    ok  = (@.User.ok.birthday val, 18)
    (eset @, 'form.valid.birthday', ok)
    return ok

  validateDisplayName: ->
    val = (eget @, 'form.values.display_name')
    ok  = (@.User.ok.displayName val)
    (eset @, 'form.valid.display_name', ok)
    return ok

  validateFullName: ->
    val = (eget @, 'form.values.full_name')
    ok  = (@.User.ok.fullName val)
    (eset @, 'form.valid.full_name', ok)
    return ok

  validateGender: ->
    val = (eget @, 'form.values.gender')
    ok  = (@.User.ok.gender val)
    (eset @, 'form.valid.gender', ok)
    return ok

  validatePhone: ->
    val = (eget @, 'form.values.phone')
    ok  = (@.User.ok.phone val)
    (eset @, 'form.valid.phone', ok)
    return ok

  formKeyPress: (action (field, e) ->
    # switch field
    #   when 'email'
    #     @sendCodeEmail() if (e.code == 'Enter' || e.code == 'NumpadEnter') && @validateForm()
    return
  )

  formValueChanged: (action ->
    if arguments.length == 2
      [ field, e ] = arguments
      (eset @, "form.values.#{field}", e.target.value)
    if arguments.length == 3
      [ field, selection, e ] = arguments
      (eset @, "form.values.#{field}", selection)

    switch field
      when 'address'        then @.validateAddress()
      when 'birthday.day'   then @.validateBirthday()
      when 'birthday.month' then @.validateBirthday()
      when 'birthday.year'  then @.validateBirthday()
      when 'display_name'   then @.validateDisplayName()
      when 'full_name'      then @.validateFullName()
      when 'gender'         then @.validateGender()
      when 'phone'          then @.validatePhone()

    @.validateForm()
    return
  )

  register: (action ->
    (eset @, 'form.submitted', true)

    if !@.validateForm()
      return

    form = (cloneDeep (eget @, 'form'))

    bd = form.values.birthday
    if !!bd
      day   = (padStart "#{bd.day}", 2, '0')
      month = (padStart "#{bd.month}", 2, '0')
      year  = (padStart "#{bd.year}", 4, '0')
      form.values.birthday = "#{year}-#{month}-#{day}"

    obj =
      form: form.values
      code: @.model.code

    reply = await (@.api.echo {
      data: obj
      path: '/v2/registrations/team-player/create'
    })

    await (all [
      (@.User.sync { force: true })
      (@.Registrations.sync { force: true })
    ])

    if reply? && reply.payment?
      data = { code: reply.payment.val.code }
      data = (JSON.stringify data)
      data = (lz.compressToEncodedURIComponent data)
      window.location = "#{window.location.origin}/pay##{data}"
    else
      (@.router.transitionTo 'app.registrations')

    return
  )

  toggleHelp: (action (field) ->
    (eset @, "form.help.#{field}", !(eget @, "form.help.#{field}"))
    return
  )


})