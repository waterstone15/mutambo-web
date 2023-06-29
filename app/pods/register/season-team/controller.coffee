import * as lz from 'lz-string'
import cloneDeep from 'lodash/cloneDeep'
import Controller from '@ember/controller'
import every from 'lodash/every'
import isString from 'lodash/isString'
import values from 'lodash/values'
import padStart from 'lodash/padStart'
import { action, computed, get, set } from '@ember/object'
import { all } from 'rsvp'
import { inject as I } from '@ember/service'
import { DateTime } from 'luxon'

export default Controller.extend({

  api:    I('api')
  router: I('router')

  User:          I('models/user')
  Registrations: I('models/registrations')

  title_string: computed('model.illst.val.league.name', 'model.illst.val.season.name', ->
    league_name = get(@, 'model.illst.val.league.val.name')
    season_name = get(@, 'model.illst.val.season.val.name')
    title = (league_name || 'League') + ', ' + (season_name || 'Season') + ' → Team Registration - Mutambo'
    return title
  )

  validateForm: ->
    formOk = every(values(get(@, 'form.valid')))
    set(@, 'form.ok', formOk)
    return formOk

  validateAddress: ->
    val = get(@, 'form.values.address')
    ok  = @.User.ok.address(val)
    set(@, 'form.valid.address', ok)
    return ok

  validateBirthday: ->
    val = get(@, 'form.values.birthday')
    ok  = @.User.ok.birthday(val, 18)
    set(@, 'form.valid.birthday', ok)
    return ok

  validateDisplayName: ->
    val = get(@, 'form.values.display_name')
    ok  = @.User.ok.displayName(val)
    set(@, 'form.valid.display_name', ok)
    return ok

  validateFullName: ->
    val = get(@, 'form.values.full_name')
    ok  = @.User.ok.fullName(val)
    set(@, 'form.valid.full_name', ok)
    return ok

  validateGender: ->
    val = get(@, 'form.values.gender')
    ok  = @.User.ok.gender(val)
    set(@, 'form.valid.gender', ok)
    return ok

  validatePhone: ->
    val = get(@, 'form.values.phone')
    ok  = @.User.ok.phone(val)
    set(@, 'form.valid.phone', ok)
    return ok

  validateTeamName: ->
    val = (get @, 'form.values.team_name')
    ok  = (isString val) && (1 <= val.length <= 50)
    set(@, 'form.valid.team_name', ok)
    return ok

  validateTeamNotes: ->
    val = get(@, 'form.values.team_notes')
    ok  = true # not a required field
    set(@, 'form.valid.team_notes', ok)
    return ok

  formKeyPress: action((field, e) ->
    # switch field
    #   when 'email'
    #     @sendCodeEmail() if (e.code == 'Enter' || e.code == 'NumpadEnter') && @validateForm()
    return
  )

  formValueChanged: action(() ->
    if arguments.length == 2
      [ field, e ] = arguments
      set(@, "form.values.#{field}", e.target.value)
    if arguments.length == 3
      [ field, selection, e ] = arguments
      set(@, "form.values.#{field}", selection)

    switch field
      when 'address'        then @validateAddress()
      when 'birthday.day'   then @validateBirthday()
      when 'birthday.month' then @validateBirthday()
      when 'birthday.year'  then @validateBirthday()
      when 'display_name'   then @validateDisplayName()
      when 'full_name'      then @validateFullName()
      when 'gender'         then @validateGender()
      when 'phone'          then @validatePhone()
      when 'team_name'      then @validateTeamName()
      when 'team_notes'     then @validateTeamNotes()

    @validateForm()
    return
  )

  register: action(->
    set(@, 'form.submitted', true)

    if !@validateForm()
      return

    form = cloneDeep(get(@, 'form'))

    bd = form.values.birthday
    if !!bd
      day   = padStart("#{bd.day}", 2, '0')
      month = padStart("#{bd.month}", 2, '0')
      year  = padStart("#{bd.year}", 4, '0')
      form.values.birthday = "#{year}-#{month}-#{day}"

    obj =
      form: form.values
      code: @.model.code

    reply = await @.api.echo({
      data: obj
      path: '/v2/registrations/season-team/create'
    })

    await all([
      @.User.sync({ force: true })
      @.Registrations.sync({ force: true })
    ])
    
    if reply? && reply.payment?
      data = { code: reply.payment.val.code }
      data = JSON.stringify(data)
      data = lz.compressToEncodedURIComponent(data)
      window.location = "#{window.location.origin}/pay##{data}"
    else
      @.router.transitionTo('app.registrations')

    return
  )

  toggleHelp: action((field) ->
    set(@, "form.help.#{field}", !get(@, "form.help.#{field}"))
    return
  )


})