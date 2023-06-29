import Controller from '@ember/controller'
import { computed } from '@ember/object'
import { get as eget } from '@ember/object'

export default Controller.extend({

  league_id: ''
  season_id: ''
  queryParams: [ 'league_id', 'season_id' ]

  title_string: (computed 'model.league.val.name', 'model.season.val.name', ->
    league_name = (eget @, 'model.league.val.name')
    season_name = (eget @, 'model.season.val.name')
    title = (league_name || 'League') + ' → ' + (season_name || 'Season')  + ' → Teams - Mutambo'
    return title
  )

})

