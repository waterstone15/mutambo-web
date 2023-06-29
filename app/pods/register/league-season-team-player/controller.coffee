import Controller from '@ember/controller'
import env from 'mutambo-web/config/environment'
import every from 'lodash/every'
import fetch from 'fetch'
import isString from 'lodash/isString'
import merge from 'lodash/merge'
import values from 'lodash/values'
import { action, computed, get, set } from '@ember/object'
import { all } from 'rsvp'
import { inject as I} from '@ember/service'

export default Controller.extend({

  code: null
  id: null
  notice: null
  queryParams: [ 'id', 'code' ]

  fb:     I('fb-init')
  router: I('router')

  PlayerCards:   I('models/player-cards')
  Registrations: I('models/registrations')
  Teams:         I('models/teams')
  User:          I('models/user')

  title_string: computed('model.illstp.val.league.val.name', 'model.illstp.val.season.val.name', 'model.illstp.val.team.val.name', ->
    league_name = get(this, 'model.illstp.val.league.val.name')
    season_name = get(this, 'model.illstp.val.season.val.name')
    team_name = get(this, 'model.illstp.val.team.val.name')
    title = (league_name || 'League') + ', ' + (season_name || 'Season') + ' → ' + (team_name || 'Team') + ' → Player Registration - Mutambo'
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
      res = await fetch("#{env.app.apiUrl}/v1/registrations/league-season-team-player", {
        method: 'POST'
        body: JSON.stringify({
          code:   get(this, 'code') ? 'default'
          form:   form
          illstp: get(this, 'model.illstp')
         })
        headers
      })
      data = await res.json()
    catch e
      console.log e

    await all([
      @User.sync({ force: true })
      @Registrations.sync({ force: true })
      @Teams.sync({ force: true })
    ])

    @router.transitionTo('app.teams')
    return
  )

  toggleHelp: action((field) ->
    set(this, "form.help.#{field}", !get(this, "form.help.#{field}"))
    return
  )


})