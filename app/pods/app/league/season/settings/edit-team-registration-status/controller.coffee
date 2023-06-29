import Controller from '@ember/controller'
import env from 'mutambo-web/config/environment'
import every from 'lodash/every'
import fetch from 'fetch'
import includes from 'lodash/includes'
import _set from 'lodash/set'
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
    title = "#{l_name} → #{s_name} → Settings → Team Registration - Mutambo"
    return title
  )

  validateForm: ->
    ok = every(values(get(@, 'form.valid')))
    set(@, 'form.ok', ok)
    return ok

  formKeyPress: action((field, selection, e) ->
    set(@, 'form.values.status', selection)
    return
  )

  formValueChanged: action((field, selection, e) ->
    set(@, 'form.values.status', selection)
    @validateForm()
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
    _set(obj, 'val.status', form.values.status)
    _set(obj, 'rel.season', season_id)

    reply = await @api.echo({
      data: obj
      path: "/v2/season-settings/team-registration-status/update"
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
