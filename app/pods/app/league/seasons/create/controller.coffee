import Controller from '@ember/controller'
import env from 'mutambo-web/config/environment'
import every from 'lodash/every'
import fetch from 'fetch'
import isEmpty from 'lodash/isEmpty'
import isString from 'lodash/isString'
import trim from 'lodash/trim'
import values from 'lodash/values'
import { action, computed, get, set } from '@ember/object'
import { inject as I } from '@ember/service'

export default Controller.extend({

  league_id: ''
  queryParams: [ 'league_id' ]

  api:    I('api')
  router: I('router')

  League: I('models/league')
  User:   I('models/user')

  title_string: computed('model.league.val.name', ->
    league_name = get(this, 'model.league.val.name')
    title = (league_name || 'League') + ' → Create New Season - Mutambo'
    return title
  )

  validateForm: ->
    ok = every(values(get(this, 'form.valid')))
    set(this, 'form.ok', ok)
    return ok

  validateSeasonName: ->
    sn = trim(get(this, 'form.values.season_name'))
    ok = isString(sn) && !isEmpty(sn)
    set(this, 'form.valid.season_name', ok)
    return ok

  formKeyPress: action((field, e) ->
    switch field
      when 'season_name'
        this.sendCodeEmail() if (e.code == 'Enter' || e.code == 'NumpadEnter') && this.validateForm()
    return
  )

  formValueChanged: action((field, e) ->
    set(this, "form.values.#{field}", e.target.value)

    switch field
      when 'season_name' then this.validateSeasonName()

    this.validateForm()
    return
  )

  save: action(->
    set(this, 'form.submitted', true)

    if !this.validateForm()
      return

    form = get(this, 'form')
    obj =
      rel: { league: get(this, 'model.league.meta.id') }
      val: { name: trim(form.values.season_name) }

    reply = await this.api.echo({ path: "/v2/seasons/create", data: obj })

    await @League.sync({ league_id: this.model.league.meta.id, force: true })
    this.router.transitionTo('app.league.index', { queryParams: { league_id: this.model.league.meta.id }})

    return
  )

  toggleHelp: action((field) ->
    set(this, "form.help.#{field}", !get(this, "form.help.#{field}"))
    return
  )


})