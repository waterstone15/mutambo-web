import Route from '@ember/routing/route'
import { inject } from '@ember/service'

export default Route.extend({

  router: inject('router')

  LSeasons: I('models/league-seasons')

  beforeModel: (transition) ->
    { league_id, season_id } = transition.to.queryParams
    this.replaceWith('app.league.free-agents', { queryParams: { league_id }})
    return

})
