import Controller from '@ember/controller'
import { inject } from '@ember/service'

export default Controller.extend({

  league_id: ''
  season_id: ''
  queryParams: [ 'league_id', 'season_id' ]

})

