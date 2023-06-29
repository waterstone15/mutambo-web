import Route from '@ember/routing/route'
import { all } from 'rsvp'
import { inject as I } from '@ember/service'

export default Route.extend({

  queryParams:
    season_id: { refreshModel: true, replace: true }

  auth: I('auth')

  Standings: I('models/standings')

  model: (params) ->
    { season_id } = params

    [ isLoggedIn, standings ] = await all([
      @auth.isLoggedIn()
      @Standings.sync({ season_id })
    ])

    return { standings, isLoggedIn }

})
