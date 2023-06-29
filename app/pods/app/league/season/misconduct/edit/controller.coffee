import Controller from '@ember/controller'
import every from 'lodash/every'
import set from 'lodash/set'
import values from 'lodash/values'
import { action } from '@ember/object'
import { computed } from '@ember/object'
import { get as eget } from '@ember/object'
import { inject as I } from '@ember/service'
import { set as eset } from '@ember/object'

export default (Controller.extend {

  api:    I()
  router: I()

  league_id:     ''
  misconduct_id: ''
  season_id:     ''
  queryParams: [ 'league_id', 'misconduct_id', 'season_id' ]

  title_string: (computed 'model.league.val.name', 'model.season.val.name', ->
    ln = @.model.league?.val?.name ? 'League'
    sn = @.model.season?.val?.name ? 'Season'
    return "#{ln} → #{sn} → Misconduct → Edit Misconduct - Mutambo"
  )

  validateForm: ->
    ok = (every (values (eget @, 'form.valid')))
    (eset @, 'form.ok', ok)
    return ok

  validateStatus: ->
    val = (eget @, 'form.values.status')
    ok = true
    (eset @, 'form.valid.status', ok)
    return ok

  formValueChanged: (action ->
    if arguments.length == 2
      [ field, e ] = arguments
      (eset @, "form.values.#{field}", e.target.value)
    if arguments.length == 3
      [ field, selection, e ] = arguments
      (eset @, "form.values.#{field}", selection)

    switch field
      when 'status' then @.validateStatus()

    @.validateForm()
    return
  )

  toggleHelp: (action (field) ->
    (eset @, "form.help.#{field}", !(eget @, "form.help.#{field}"))
    return
  )

  save: (action ->
    (eset @, 'form.submitted', true)

    if !@.validateForm()
      return

    form = (eget @, 'form')
    league_id = @.model.league.meta.id
    season_id = @.model.season.meta.id

    obj = {}
    (set obj, 'meta.id',    @.model.misconduct.meta.id)
    (set obj, 'rel.season', season_id)
    (set obj, 'val.status', form.values.status)

    reply = await (@.api.echo {
      data: obj
      path: "/v2/season/misconduct/update"
    })

    q = { queryParams: { league_id, season_id }}
    @.router.transitionTo('app.league.season.misconducts', q)
    return
  )

})
