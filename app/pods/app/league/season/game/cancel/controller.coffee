import Controller from '@ember/controller'
import every from 'lodash/every'
import set from 'lodash/set'
import toLower from 'lodash/toLower'
import trim from 'lodash/trim'
import values from 'lodash/values'
import { action } from '@ember/object'
import { computed } from '@ember/object'
import { get as eget } from '@ember/object'
import { inject as I } from '@ember/service'
import { set as eset } from '@ember/object'

export default (Controller.extend {

  api:    I()
  router: I()

  game_id:   ''
  league_id: ''
  season_id: ''
  queryParams: [ 'game_id', 'league_id', 'season_id' ]

  title_string: (computed 'model.league.val.name', 'model.season.val.name', ->
    ln = @.model.league?.val?.name ? 'League'
    sn = @.model.season?.val?.name ? 'Season'
    return "#{ln} → #{sn} → Games → Delete Game - Mutambo"
  )

  validateForm: ->
    ok = (every (values (eget @, 'form.valid')))
    (eset @, 'form.ok', ok)
    return ok

  validateConfirmText: ->
    val = (eget @, 'form.values.confirm_text')
    ok  = ((toLower val) == 'cancel')
    (eset @, 'form.valid.confirm_text', ok)
    return ok
  
  formValueChanged: (action ->
    if arguments.length == 2
      [ field, e ] = arguments
      (eset @, "form.values.#{field}", e.target.value)
    if arguments.length == 3
      [ field, selection, e ] = arguments
      (eset @, "form.values.#{field}", selection)

    switch field
      when 'confirm_text' then @.validateConfirmText()

    @.validateForm()
    return
  )

  toggleHelp: (action (field) ->
    (eset @, "form.help.#{field}", !(eget @, "form.help.#{field}"))
    return
  )

  confirm: (action ->
    (eset @, 'form.submitted', true)

    if !@.validateForm()
      return

    form = (eget @, 'form')
    league_id = @.model.league.meta.id
    season_id = @.model.season.meta.id

    obj = {}
    (set obj, 'meta.id',      @.model.game.meta.id)
    (set obj, 'rel.season',   season_id)
    (set obj, 'val.canceled', true)


    reply = await (@.api.echo {
      data: obj
      path: "/v2/season/game/cancel"
    })

    q = { queryParams: { league_id, season_id }}
    @.router.transitionTo('app.league.season.games', q)
    return
  )

})
