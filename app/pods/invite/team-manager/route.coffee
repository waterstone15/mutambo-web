import * as lz from 'lz-string'
import Route from '@ember/routing/route'
import { inject as I } from '@ember/service'
import { all } from 'rsvp'

export default (Route.extend {

  auth:   I()
  router: I()

  ITM: (I 'models/invite/team-manager')

  beforeModel: ->
    await (@.auth.waypoint { notice: 'invite/team-manager'})
    return

  model: ->
    hash     = window.location.hash
    data     = (lz.decompressFromEncodedURIComponent hash[1..])
    { code } = (JSON.parse data)

    [ isLoggedIn, itm ] = await (all [
      (@.auth.isLoggedIn())
      (@.ITM.sync { code })
    ])

    if itm.val.team.val.is_manager
      (@.router.transitionTo 'app.team', {
        queryParams: { team_id: itm.val.team.meta.id }
      })

    return { code, hash, isLoggedIn, itm }

})

