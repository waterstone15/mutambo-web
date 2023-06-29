import Route from '@ember/routing/route'
import { all } from 'rsvp'
import { inject as I } from '@ember/service'

export default (Route.extend {

  queryParams:
    season_id: { refreshModel: true }

  auth:   I()
  router: I()

  GDivisions: (I 'models/global/divisions')

  model: (params) ->
    { season_id } = params

    [ gds, user, ] = await (all [
      (@.GDivisions.sync { season_id })
      (@.auth.isLoggedIn())
    ])

    { divisions, league, season } = gds

    return { divisions, league, season, user }

})
