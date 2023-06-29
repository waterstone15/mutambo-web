import * as lz from 'lz-string'
import Route from '@ember/routing/route'
import { inject as I } from '@ember/service'
import { all } from 'rsvp'

export default (Route.extend {

  auth:   I()
  router: I()

  ITP: (I 'models/invite/team-player')

  beforeModel: ->
    await (@.auth.waypoint { notice: 'invite/team-player'})
    return

  model: ->
    hash     = window.location.hash
    data     = (lz.decompressFromEncodedURIComponent hash[1..])
    { code } = (JSON.parse data)

    [ isLoggedIn, itp ] = await (all [
      (@.auth.isLoggedIn())
      (@.ITP.sync { code })
    ])

    if itp.val.team.val.is_player
      (@.router.transitionTo 'app.team', {
        queryParams: { team_id: itp.val.team.meta.id }
      })

    return { code, hash, isLoggedIn, itp }

})

