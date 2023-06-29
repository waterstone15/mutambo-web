import Route from '@ember/routing/route'
import { all } from 'rsvp'
import { inject as I } from '@ember/service'

export default (Route.extend {

  queryParams:
    league_id: { refreshModel: true }
    season_id: { refreshModel: true }

  auth:   I()
  router: I()

  GStandings: (I 'models/global/standings')

  model: (params) ->
    { league_id, season_id } = params

    [ gst, user, ] = await (all [
      @.GStandings.sync({ league_id, season_id })
      @.auth.isLoggedIn()
    ])

    console.log JSON.stringify gst, 2, 2

    { standings, league, season } = gst

    return { standings, league, season, user }

})
