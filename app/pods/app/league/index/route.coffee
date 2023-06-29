import * as lz from 'lz-string'
import EmberObject from '@ember/object'
import Route from '@ember/routing/route'
import set from 'lodash/set'
import { all } from 'rsvp'
import { inject as I } from '@ember/service'

export default Route.extend({

  queryParams:
    league_id: { refreshModel: true }

  auth:   I()
  router: I()
  
  InviteCodeLFA: I('models/invite-code/league-free-agent')
  League:        I('models/league')
  Leagues:       I('models/leagues')
  LSeasons:      I('models/league-seasons')
  User:          I('models/user')

  beforeModel: ->
    await @.auth.waypoint()
    return

  model: (params) ->
    { league_id } = params
    [ iclfa, league, leagues, seasons, user, ] = await all([
      @.InviteCodeLFA.sync({ league_id })
      @.League.sync({ league_id })
      @.Leagues.sync()
      @.LSeasons.sync({ league_id })
      @.User.sync()
    ])

    if iclfa
      data = { code: iclfa.val.code }
      data = JSON.stringify(data)
      data = lz.compressToEncodedURIComponent(data)
      set(iclfa, 'ui.link', "#{window.location.origin}/invite/league-free-agent##{data}")

    return { iclfa, league, leagues, seasons, user }

})
