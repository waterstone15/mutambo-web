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

  fb: inject('fb-init')
  id: null
  notice: null
  queryParams: [ 'id' ]
  router: inject()
  PlayerCards: inject('models/player-cards')
  User: inject('models/user')

  title_string: computed('model.league.val.name', ->
    league_name = get(this, 'model.league.val.name')
    title = (league_name || 'League') + ' → Registration → Free Agent - Mutambo'
    return title
  )

  validateForm: ->
    formOk = every(values(get(this, 'form.valid')))
    set(this, 'form.ok', formOk)
    return formOk

  validateAbout: ->
    about = get(this, 'form.values.about')
    aboutOk = isString(about) && about.length > 0
    set(this, 'form.valid.about', aboutOk)
    return aboutOk

  validateDisplayName: ->
    dn = get(this, 'form.values.display_name')
    dnOk = isString(dn) && dn.length > 0
    set(this, 'form.valid.display_name', dnOk)
    return dnOk

  formKeyPress: action((field, e) ->
    switch field
      when 'email'
        this.sendCodeEmail() if (e.code == 'Enter' || e.code == 'NumpadEnter') && this.validateForm()
    return
  )

  formValueChanged: action((field, e) ->
    set(this, "form.values.#{field}", e.target.value)

    switch field
      when 'about' then this.validateAbout()
      when 'display_name' then this.validateDisplayName()

    this.validateForm()
    return
  )

  register: action(->
    set(this, 'form.submitted', true)

    this.validateDisplayName()
    this.validateAbout()

    if !this.validateForm()
      return

    form = get(this, 'form')
    card = merge(get(this, 'model.card'), {
      val:
        about: form.values.about
        name: form.values.display_name
    })

    fb      = await this.fb.get()
    token   = await fb.auth().currentUser.getIdToken()
    headers = { 'Content-Type': 'application/json', 'firebase-auth-token': token }
    try
      res = await fetch("#{env.app.apiUrl}/v1/registrations/league-free-agent", {
        method: 'POST'
        body: JSON.stringify({ invite_link: this.model.invite_link, player_card: card })
        headers
      })
      data = await res.json()
    catch e
      console.log e
    await all([
      @User.sync({ force: true })
      @PlayerCards.sync({ force: true })
    ])
    @router.transitionTo('app.player-cards')
    return
  )

  toggleHelp: action((field) ->
    set(this, "form.help.#{field}", !get(this, "form.help.#{field}"))
    return
  )


})