import * as lz from 'lz-string'
import * as money from 'currency.js'
import compact from 'lodash/compact'
import get from 'lodash/get'
import isEmpty from 'lodash/isEmpty'
import map from 'lodash/map'
import merge from 'lodash/merge'
import Route from '@ember/routing/route'
import set from 'lodash/set'
import split from 'lodash/split'
import uppercase from 'lodash/uppercase'
import { all } from 'rsvp'
import { DateTime } from 'luxon'
import { inject as I } from '@ember/service'

export default (Route.extend {

  queryParams:
    c:         { refreshModel: true, replace: true }
    f_type:    { refreshModel: true, replace: true }
    p:         { refreshModel: true, replace: true }
    league_id: { refreshModel: true }
    season_id: { refreshModel: true }

  auth:   I()
  router: I()

  League:          (I 'models/league')
  Leagues:         (I 'models/leagues')
  LSeasons:        (I 'models/league-seasons')
  LSRegistrations: (I 'models/season/registrations')
  Season:          (I 'models/season')
  User:            (I 'models/user')

  beforeModel: ->
    await @.auth.waypoint()
    return

 
  model: (params) ->
    { c, f_type, p, league_id, season_id } = params
    
    fs = { type: (f_type ? 'all') }

    [ league, leagues, registrations, season, seasons, user, ] = await (all [
      (@.League.sync { league_id })
      (@.Leagues.sync())
      (@.LSRegistrations.sync { c, fs, p, season_id })
      (@.Season.sync { season_id })
      (@.LSeasons.sync { league_id })
      (@.User.sync())
    ])

    if !season.val.is_admin
      (@.router.transitionTo 'app.hello') 
      return

    registrations.page.items = (map registrations.page.items, (_r) ->
      
      pmt = (get _r, 'val.payment')

      if !(isEmpty pmt)
        data = { code: pmt.val.code }
        data = JSON.stringify(data)
        data = lz.compressToEncodedURIComponent(data)

      return (merge _r, {
        ui:
          currency:   (uppercase ((get pmt, 'val.currency') || 'USD'))
          link:       if !(isEmpty pmt) then "#{window.location.origin}/pay##{data}"
          notes:      (compact (split (get _r, 'val.form.team_notes'), '\n'))
          total:      (money ((get pmt, 'val.total') || 0), { pattern: '#' }).format()
          updated_at: DateTime.fromISO(_r.meta.updated_at).toFormat('yyyy.M.d')
      })
    )

    return { league, leagues, registrations, season, seasons, user, }


  setupController: (controller, model) ->
    (@._super controller, model)

    props = {
      form:
        ok:        false
        submitted: false
        errors: {}
        help: {}
        valid: {}
        values:
          filter_type: (controller.f_type ? 'all')
          filter_team: 'all'
    }
    (controller.setProperties props)
    return

})
