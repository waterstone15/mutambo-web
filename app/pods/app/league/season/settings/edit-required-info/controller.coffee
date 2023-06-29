import _set from 'lodash/set'
import Controller from '@ember/controller'
import every from 'lodash/every'
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
    ln = @model.league?.val?.name ? 'League'
    sn = @model.season?.val?.name ? 'Season'
    title = "#{ln} → #{sn} → Settings → Required Information - Mutambo"
    return title
  )

  validateForm: ->
    ok = every(values(get(@, 'form.valid')))
    set(@, 'form.ok', ok)
    return ok


  formKeyPress: action((field, e) ->
    return
  )

  formValueChanged: action((field, e) ->
    set(this, "form.values.#{field}", e.target.value)

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
    _set(obj, 'val.info', form.values.info)
    _set(obj, 'rel.season', season_id)

    reply = await @api.echo({
      data: obj
      path: "/v2/season-settings/required-info/update"
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

  toggleInfo: action((path) ->
    set(@, "form.values.info.#{path}", !get(@, "form.values.info.#{path}"))
    return
  )

})
