import Route from '@ember/routing/route'
import toInteger from 'lodash/toInteger'
import { all } from 'rsvp'
import { DateTime } from 'luxon'
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

    now = DateTime.local()

    (controller.setProperties {
      min_year: (toInteger (now.toFormat 'yyyy')) - 1
      max_year: (toInteger (now.toFormat 'yyyy')) + 20
      form:
        ok:              false
        submitted:       false
        errors:
          ext_id:        []
          location_text: []
          home_team:     []
          away_team:     []
        help:
          datetime:      false
          ext_id:        false
          location_text: false
          home_team:     false
          away_team:     false
        valid:
          away_team:     false
          datetime:      true
          day:           true
          ext_id:        true
          home_team:     false
          hour:          true
          location_text: true
          meridiem:      true
          minute:        true
          month:         true
          timezone:      true
          year:          true
        values:
          year:          (toInteger (now.toFormat 'y'))
          month:         (toInteger (now.toFormat 'L'))
          day:           (toInteger (now.toFormat 'd'))
          hour:          (toInteger (now.toFormat 'h'))
          minute:        (toInteger (now.toFormat 'm'))
          meridiem:      (now.toFormat 'a')
          timezone:      'America/Chicago'
          # 
          away_team:     null
          ext_id:        ''
          home_team:     null
          location_text: 'TBD'
        warnings:
          datetime:      false
          divisions:     false
    })
    return

})
