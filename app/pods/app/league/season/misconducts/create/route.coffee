import Route from '@ember/routing/route'
import toInteger from 'lodash/toInteger'
import { all } from 'rsvp'
import { inject as I } from '@ember/service'

export default Route.extend({

  queryParams:
    league_id: { refreshModel: true, replace: true }
    season_id: { refreshModel: true, replace: true }

  auth:   I()
  router: I()

  League:   (I 'models/league')
  Leagues:  (I 'models/leagues')
  LSeasons: (I 'models/league-seasons')
  LSTeams:  (I 'models/season/teams')
  Season:   (I 'models/season')
  User:     (I 'models/user')

  beforeModel: ->
    await @.auth.waypoint()
    return

  model: (params) ->
    { league_id, season_id, } = params

    [ league, leagues, seasons, teams, season, user, ] = await all([
      @.League.sync({ league_id })
      @.Leagues.sync()
      @.LSeasons.sync({ league_id })
      @.LSTeams.sync({ season_id })
      @.Season.sync({ season_id })
      @.User.sync()
    ])
    teams = teams.page.items
    
    return { league, leagues, seasons, teams, season, user, }


  setupController: (controller, model) ->
    (@._super controller, model)

    (controller.setProperties {
      people:      []
      games:       []
      form:
        ok:         false
        submitted:  false
        errors:
          demerits: []
          fee:      []
          game:     []
          person:   []
          scope:    []
          team:     []
        help:
          demerits: false
          fee:      false
          game:     false
          person:   false
          scope:    false
          team:     false
        valid:
          demerits: true
          fee:      true
          game:     false
          person:   false
          scope:    true
          team:     false
        values:
          demerits: 0
          fee:      '0.00'
          game:     null
          person:   null
          scope:    'team'
          team:     null
        warnings:
          demerits: false
          fee:      false
          game:     false
          person:   false
          scope:    false
          team:     false
    })
    return

})
