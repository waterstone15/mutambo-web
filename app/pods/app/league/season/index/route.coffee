import * as lz from 'lz-string'
import isEmpty from 'lodash/isEmpty'
import Route from '@ember/routing/route'
import set from 'lodash/set'
import { all } from 'rsvp'
import { inject as I } from '@ember/service'

export default Route.extend({

  queryParams:
    league_id: { refreshModel: true }
    season_id: { refreshModel: true }

  auth:   I()
  router: I()

  InviteCodeSA: (I 'models/invite-code/season-admin')
  InviteCodeST: (I 'models/invite-code/season-team')
  League:       (I 'models/league')
  Leagues:      (I 'models/leagues')
  LSeasons:     (I 'models/league-seasons')
  Season:       (I 'models/season')
  User:         (I 'models/user')

  beforeModel: ->
    await @.auth.waypoint()
    return

  model: (params) ->
    { league_id, season_id, } = params
    [ icsa, icst, league, leagues, seasons, season, user, ] = await all([
      @.InviteCodeSA.sync({ season_id })
      @.InviteCodeST.sync({ season_id })
      @.League.sync({ league_id })
      @.Leagues.sync()
      @.LSeasons.sync({ league_id })
      @.Season.sync({ season_id, force: true })
      @.User.sync()
    ])

    if !(isEmpty icsa)
      data = { code: icsa.val.code }
      data = (JSON.stringify data)
      data = (lz.compressToEncodedURIComponent data)
      (set icsa, 'ui.link', "#{window.location.origin}/invite/season-admin##{data}")

    if !(isEmpty icst)
      data = { code: icst.val.code }
      data = (JSON.stringify data)
      data = (lz.compressToEncodedURIComponent data)
      (set icst, 'ui.link', "#{window.location.origin}/invite/season-team##{data}")

    return { icsa, icst, league, leagues, seasons, season, user, }

})
