import * as lz from 'lz-string'
import Route from '@ember/routing/route'
import { all } from 'rsvp'
import { inject as I } from '@ember/service'

export default (Route.extend {

  auth:   I()
  router: I()

  Invite: (I 'models/invite/season-team')

  beforeModel: ->
    await (@.auth.waypoint { notice: 'invite/season-team'})
    return

  model: ->
    hash     = window.location.hash
    data     = (lz.decompressFromEncodedURIComponent hash[1..])
    { code } = (JSON.parse data)

    [ isLoggedIn, { league, season, settings }] = await (all [
      (@.auth.isLoggedIn())
      (@.Invite.sync { code })
    ])

    return { code, hash, league, isLoggedIn, season, settings }

})

