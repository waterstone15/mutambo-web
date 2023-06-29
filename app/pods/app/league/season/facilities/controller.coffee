import Controller from '@ember/controller'
import { computed, get } from '@ember/object'

export default Controller.extend({

  league_id: ''
  season_id: ''
  queryParams: [ 'league_id', 'season_id' ]

  title_string: computed('model.league.val.name', 'model.season.val.name', ->
    league_name = get(this, 'model.league.val.name')
    season_name = get(this, 'model.season.val.name')
    title = (league_name || 'League') + ' → ' + (season_name || 'Season')  + ' →  Facilities - Mutambo'
    return title
  )

})

