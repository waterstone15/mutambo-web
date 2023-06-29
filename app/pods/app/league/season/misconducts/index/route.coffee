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
    p:         { refreshModel: true, replace: true }
    league_id: { refreshModel: true }
    season_id: { refreshModel: true }

  auth:   I()
  router: I()

  League:        (I 'models/league')
  Leagues:       (I 'models/leagues')
  LSeasons:      (I 'models/league-seasons')
  LSMisconducts: (I 'models/season/misconducts')
  Season:        (I 'models/season')
  User:          (I 'models/user')

  beforeModel: ->
    await @.auth.waypoint()
    return

  model: (params) ->
    { c, p, league_id, season_id } = params

    [ league, leagues, misconducts, season, seasons, user, ] = await (all [
      @.League.sync({ league_id })
      @.Leagues.sync()
      @.LSMisconducts.sync({ c, p, season_id })
      @.Season.sync({ season_id })
      @.LSeasons.sync({ league_id })
      @.User.sync()
    ])

    if !season.val.is_admin
      (@.router.transitionTo 'app.hello') 
      return

    misconducts.page.items = (map misconducts.page.items, (_m) ->
      
      _p   = _m.val.payment
      _pui = {}
      if _p
        _d = { code: _p.val.code }
        _d = (JSON.stringify _d)
        _d = (lz.compressToEncodedURIComponent _d)

        _pui =
          ui:
            currency:   (uppercase _p.val.currency)
            link:       if !(isEmpty _p) then "#{window.location.origin}/pay##{_d}"
            total:      (money (_p.val.total || 0), { pattern: '#' }).format()
            created_at: DateTime.fromISO(_p.meta.created_at).toFormat('yyyy.M.d')

      return (merge {}, _m, _pui)
    )

    return { league, leagues, misconducts, season, seasons, user, }

})