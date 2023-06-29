import Controller from '@ember/controller'
import { action, computed, get, } from '@ember/object'
import { inject as I } from '@ember/service'

export default Controller.extend({

  router:  I('router')

  season_id: ''
  queryParams: [ 'season_id' ]

  title_string: computed('model.standings.league.val.name', 'model.standings.season.val.name', ->
    league_name = get(this, 'model.standings.league.val.name')
    season_name = get(this, 'model.standings.season.val.name')
    title = (league_name || 'League') + ' → ' + (season_name || 'Season') + ' → Standings - Mutambo'
    return title
  )


})

