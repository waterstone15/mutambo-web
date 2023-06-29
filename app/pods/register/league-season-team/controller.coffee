import Controller from '@ember/controller'
import env from 'mutambo-web/config/environment'
import every from 'lodash/every'
import fetch from 'fetch'
import isString from 'lodash/isString'
import merge from 'lodash/merge'
import values from 'lodash/values'
import { action, computed, get, set } from '@ember/object'
import { all } from 'rsvp'
import { inject } from '@ember/service'

export default Controller.extend({

  code: null
  id: null
  notice: null
  queryParams: [ 'id', 'code' ]

  fb: inject('fb-init')
  router: inject()

  PlayerCards: inject('models/player-cards')
  User: inject('models/user')
  Teams: inject('models/teams')
  Registrations: inject('models/registrations')

  title_string: computed('model.illst.val.league.name', 'model.illst.val.season.name', ->
    league_name = get(this, 'model.illst.val.league.val.name')
    season_name = get(this, 'model.illst.val.season.val.name')
    title = (league_name || 'League') + ', ' + (season_name || 'Season') + ' → Team Registration - Mutambo'
    return title
  )

  validateForm: ->
    formOk = every(values(get(this, 'form.valid')))
    set(this, 'form.ok', formOk)
    return formOk

  validateAddress: ->
    address = get(this, 'form.values.address')
    ok = @User.ok.address(address)
    set(this, 'form.valid.address', ok)
    return ok

  validateBirthday: ->
    birthday = get(this, 'form.values.birthday')
    ok = @User.ok.birthday(birthday)
    set(this, 'form.valid.birthday', ok)
    return ok

  validateDisplayName: ->
    dn = get(this, 'form.values.display_name')
    ok = @User.ok.displayName(dn)
    set(this, 'form.valid.display_name', ok)
    return ok

  validateFullName: ->
    fn = get(this, 'form.values.full_name')
    ok = @User.ok.fullName(fn)
    set(this, 'form.valid.full_name', ok)
    return ok

  validateGender: ->
    g = get(this, 'form.values.gender')
    ok = @User.ok.gender(g)
    set(this, 'form.valid.gender', ok)
    return ok

  validatePhone: ->
    p = get(this, 'form.values.phone')
    ok = ok = @User.ok.phone(p)
    set(this, 'form.valid.phone', ok)
    return ok

  validateTeamName: ->
    tn = get(this, 'form.values.team_name')
    ok = isString(tn) && tn.length > 0
    set(this, 'form.valid.team_name', ok)
    return ok

  validateTeamNotes: ->
    tn = get(this, 'form.values.team_notes')
    ok = true # not a required field
    set(this, 'form.valid.team_notes', ok)
    return ok

  formKeyPress: action((field, e) ->
    # switch field
    #   when 'email'
    #     this.sendCodeEmail() if (e.code == 'Enter' || e.code == 'NumpadEnter') && this.validateForm()
    return
  )

  formValueChanged: action(() ->
    if arguments.length == 2
      [ field, e ] = arguments
      set(this, "form.values.#{field}", e.target.value)
    if arguments.length == 3
      [ field, selection, e ] = arguments
      set(this, "form.values.#{field}", selection)

    switch field
      when 'address' then this.validateAddress()
      when 'birthday.day' then this.validateBirthday()
      when 'birthday.month' then this.validateBirthday()
      when 'birthday.year' then this.validateBirthday()
      when 'display_name' then this.validateDisplayName()
      when 'full_name' then this.validateFullName()
      when 'gender' then this.validateGender()
      when 'phone' then this.validatePhone()
      when 'team_name' then this.validateTeamName()
      when 'team_notes' then this.validateTeamNotes()

    this.validateForm()
    return
  )

  register: action(->
    set(this, 'form.submitted', true)

    if !this.validateForm()
      return

    form   = get(this, 'form')

    fb      = await this.fb.get()
    token   = await fb.auth().currentUser.getIdToken()
    headers = { 'Content-Type': 'application/json', 'firebase-auth-token': token }
    try
      res = await fetch("#{env.app.apiUrl}/v1/registrations/league-season-team", {
        method: 'POST'
        body: JSON.stringify({
          code:  get(this, 'code') ? 'default'
          form:  form
          illst: get(this, 'model.illst')
         })
        headers
      })
      data = await res.json()
    catch e
      console.log e

    await all([
      @User.sync({ force: true })
      @Registrations.sync({ force: true })
    ])

    @router.transitionTo('pay.index', { queryParams: { code: data.payment.val.code }})
    return
  )

  toggleHelp: action((field) ->
    set(this, "form.help.#{field}", !get(this, "form.help.#{field}"))
    return
  )


})