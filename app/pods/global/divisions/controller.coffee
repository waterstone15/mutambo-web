import Controller from '@ember/controller'
import { computed } from '@ember/object'
import { get as eget } from '@ember/object'
import { inject as I } from '@ember/service'

export default (Controller.extend {

  season_id: ''
  queryParams: [ 'season_id' ]

  title_string: (computed 'model.league.val.name', 'model.season.val.name', ->
    ln    = (eget @, 'model.league.val.name')
    sln   = (eget @, 'model.season.val.name')
    title = (ln || 'League') + ' → ' + (sln || 'Season')  + ' → Divisions - Mutambo'
    return title
  )


})

