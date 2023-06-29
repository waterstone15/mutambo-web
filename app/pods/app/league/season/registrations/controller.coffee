import Controller from '@ember/controller'
import findIndex from 'lodash/findIndex'
import { action } from '@ember/object'
import { computed } from '@ember/object'
import { get as eget } from '@ember/object'
import { set as eset } from '@ember/object'
import { inject as I } from '@ember/service'

export default (Controller.extend {

  router: I()

  c: ''
  f_type: 'all'
  p: ''
  league_id: ''
  season_id: ''
  queryParams: [ 'c', 'f_type', 'p', 'league_id', 'season_id' ]

  title_string: (computed 'model.league.val.name', 'model.season.val.name', ->
    league_name = (eget @, 'model.league.val.name')
    season_name = (eget @, 'model.season.val.name')
    title = (league_name || 'League') + ' → ' + (season_name || 'Season')  + ' → Registrations - Mutambo'
    return title
  )

  show_type_filter_box: false

  toggleTypeFilterBox: (action ->
    (eset @, 'show_type_filter_box', !(eget @, 'show_type_filter_box'))
    (eset @, 'form.values.filter_type', ((eget @, 'f_type') ? 'all'))
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

  setFilterType: (action ->
  
    (@.router.transitionTo 'app.league.season.registrations', {
      queryParams:
        c: ''
        f_type: (eget @, "form.values.filter_type")
        p: ''
    })
    @.toggleTypeFilterBox()
    return
  )

})

