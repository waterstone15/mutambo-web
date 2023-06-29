import * as lz from 'lz-string'
import Route from '@ember/routing/route'
import set from 'lodash/set'
import { inject as I } from '@ember/service'
import { all } from 'rsvp'

export default Route.extend({

  auth:   I('auth')
  router: I('router')

  InviteSA: I('models/invite/season-admin')

  beforeModel: ->
    await @auth.waypoint({ notice: 'invite/season-admin'})
    return

  model: ->
    packed = window.location.hash[1..]
    data = lz.decompressFromEncodedURIComponent(packed)
    { code } = JSON.parse(data)

    [ isLoggedIn, { league, season }] = await all([
      @auth.isLoggedIn()
      @InviteSA.sync({ code })
    ])

    if season.val.is_admin
      @router.transitionTo('app.league.season.index', {
        queryParams: 
          league_id: league.meta.id
          season_id: season.meta.id
      })

    return { code, league, isLoggedIn, season }

})

