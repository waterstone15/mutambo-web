import _set from 'lodash/set'
import Controller from '@ember/controller'
import every from 'lodash/every'
import toNumber from 'lodash/toNumber'
import values from 'lodash/values'
import { action, computed, get, set } from '@ember/object'
import { inject as I } from '@ember/service'

export default Controller.extend({

  api:    I('api')
  router: I('router')

  SeasonSettings: I('models/season-settings')
  User:           I('models/user')

  league_id: ''
  season_id: ''
  queryParams: [ 'league_id', 'season_id' ]

  title_string: computed('model.league.val.name', 'model.season.val.name', ->
    l_name = @model.league?.val?.name ? 'League'
    s_name = @model.season?.val?.name ? 'Season'
    title = "#{l_name} → #{s_name} → Settings → Team Manager Limit - Mutambo"
    return title
  )

  validateForm: ->
    ok = every(values(get(@, 'form.valid')))
    set(@, 'form.ok', ok)
    return ok

  validateLimit: ->
    limit = get(this, 'form.values.limit')
    ok = (1 <= toNumber(limit) <= 10)
    set(this, 'form.valid.limit', ok)
    return ok

  formKeyPress: action((field, e) ->
    return
  )

  formValueChanged: action((field, e) ->
    set(this, "form.values.#{field}", e.target.value)

    switch field
      when 'limit' then this.validateLimit()

    this.validateForm()
    return
  )

  save: action(->
    set(@, 'form.submitted', true)

    if !@validateForm()
      return

    form = get(@, 'form')
    league_id = @model.league.meta.id
    season_id = @model.season.meta.id

    obj = {}
    _set(obj, 'val.limit', toNumber(form.values.limit))
    _set(obj, 'rel.season', season_id)

    reply = await @api.echo({
      data: obj
      path: "/v2/season-settings/team-manager-limit/update"
    })

    await @SeasonSettings.sync({ season_id, force: true }) if reply?
    
    q = { queryParams: { league_id, season_id }}
    @router.transitionTo('app.league.season.settings', q)
    return
  )

  toggleHelp: action((field) ->
    set(@, "form.help.#{field}", !get(@, "form.help.#{field}"))
    return
  )

})
