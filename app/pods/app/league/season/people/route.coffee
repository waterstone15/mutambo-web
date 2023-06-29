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
    f_role:    { refreshModel: true, replace: true }
    league_id: { refreshModel: true }
    season_id: { refreshModel: true }

  auth:   I()
  router: I()

  League:   (I 'models/league')
  Leagues:  (I 'models/leagues')
  LSeasons: (I 'models/league-seasons')
  LSPeople: (I 'models/season/people')
  Season:   (I 'models/season')
  User:     (I 'models/user')

  beforeModel: ->
    await @.auth.waypoint()
    return

  model: (params) ->
    { c, p, f_role, league_id, season_id } = params

    fs = { role: (f_role ? 'all') }

    [ league, leagues, people, season, seasons, user, ] = await (all [
      (@.League.sync { league_id })
      (@.Leagues.sync())
      (@.LSPeople.sync { c, fs, p, season_id })
      (@.Season.sync { season_id })
      (@.LSeasons.sync { league_id })
      (@.User.sync())
    ])

    if !season.val.is_admin
      (@.router.transitionTo 'app.hello') 
      return

    return { league, leagues, people, season, seasons, user, }

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
          filter_role: (controller.f_role ? 'all')
          filter_team: 'all'
    }
    (controller.setProperties props)
    return

})
