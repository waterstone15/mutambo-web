import Controller from '@ember/controller'
import find from 'lodash/find'
import findIndex from 'lodash/findIndex'
import merge from 'lodash/merge'
import pick from 'lodash/pick'
import { action } from '@ember/object'
import { computed } from '@ember/object'
import { get as eget } from '@ember/object'
import { inject as I } from '@ember/service'
import { set as eset } from '@ember/object'

export default (Controller.extend {

  api: I()

  league_id: ''
  season_id: ''
  queryParams: [ 'league_id', 'season_id' ]

  title_string: (computed 'model.league.val.name', 'model.season.val.name', ->
    league_name = (eget @, 'model.league.val.name')
    season_name = (eget @, 'model.season.val.name')
    title = (league_name || 'League') + ' → ' + (season_name || 'Season')  + ' → Teams - Mutambo'
    return title
  )

  formValueChanged: (action ->
    if arguments.length == 2
      [ field, e ] = arguments
      (eset @, "form.values.#{field}", e.target.value)
    if arguments.length == 3
      [ field, selection, e ] = arguments
      (eset @, "form.values.#{field}", selection)

    return
  )

  show_change_division_box: false

  toggleChangeDivisionBox: (action (_tid, _did) ->
    team     = (find @.model.teams.page.items, { meta: { id: _tid }})
    division = (find @.model.divisions, { meta: { id: _did }})

    (eset @, 'form.values.team',     team)
    (eset @, 'form.values.division', division)

    (eset @, 'show_change_division_box', !(eget @, 'show_change_division_box'))
    return
  )

  setDivision: (action ->
    obj = (merge (eget @, 'form.values'), { season: @.model.season })
    obj = (pick obj, [ 'division.meta.id', 'season.meta.id', 'team.meta.id', ])
    
    reply = await (@.api.echo {
      data: obj
      path: "/v2/season/team/division/update"
    })

    (@.send 'toggleChangeDivisionBox')
    (@.send 'reload')
    return
  )

})

