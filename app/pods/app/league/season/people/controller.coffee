import Controller from '@ember/controller'
import findIndex from 'lodash/findIndex'
import { action } from '@ember/object'
import { computed } from '@ember/object'
import { get as eget } from '@ember/object'
import { set as eset } from '@ember/object'
import { inject as I } from '@ember/service'

export default Controller.extend({

  router: I()

  c: ''
  p: ''
  f_role: 'all'
  league_id: ''
  season_id: ''
  queryParams: [ 'c', 'p', 'f_role', 'league_id', 'season_id' ]

  title_string: (computed 'model.league.val.name', 'model.season.val.name', ->
    ln = (eget @, 'model.league.val.name')
    ns = (eget @, 'model.season.val.name')
    title = (ln || 'League') + ' → ' + (ns || 'Season')  + ' → People - Mutambo'
    return title
  )

  show_role_filter_box: false

  toggleRoleFilterBox: (action ->
    (eset @, 'show_role_filter_box', !(eget @, 'show_role_filter_box'))
    (eset @, 'form.values.filter_role', ((eget @, 'f_role') ? 'all'))
    return
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

  setFilterRole: (action ->
  
    (@.router.transitionTo 'app.league.season.people', {
      queryParams:
        c: ''
        f_role: (eget @, "form.values.filter_role")
        p: ''
    })
    @.toggleRoleFilterBox()
    return
  )

})

