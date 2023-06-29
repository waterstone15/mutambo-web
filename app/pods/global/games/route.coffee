import Route from '@ember/routing/route'
import { all } from 'rsvp'
import { inject as I } from '@ember/service'

export default (Route.extend {

  queryParams:
    c:         { refreshModel: true, replace: true }
    p:         { refreshModel: true, replace: true }
    season_id: { refreshModel: true }

  auth:   I()
  router: I()

  GGames: (I 'models/global/games')

  model: (params) ->
    { c, p, season_id } = params

    [ ggs, user, ] = await (all [
      (@.GGames.sync { c, p, season_id })
      (@.auth.isLoggedIn())
    ])

    { games, league, season } = ggs

    return { games, league, season, user }

})
