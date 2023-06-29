import Controller from '@ember/controller'
import env from 'mutambo-web/config/environment'
import { computed } from '@ember/object'
import { get as eget } from '@ember/object'

export default (Controller.extend {

  env: env

  league_id: ''
  season_id: ''
  c: ''
  p: ''
  queryParams: [ 'c', 'p', 'league_id', 'season_id' ]

  title_string: (computed 'model.league.val.name', 'model.season.val.name', ->
    league_name = (eget @, 'model.league.val.name')
    season_name = (eget @, 'model.season.val.name')
    title = (league_name || 'League') + ' → ' + (season_name || 'Season')  + ' → Games - Mutambo'
    return title
  )

})

