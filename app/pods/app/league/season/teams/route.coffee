import Route from '@ember/routing/route'
import { all } from 'rsvp'
import { inject as I } from '@ember/service'

export default (Route.extend {

  queryParams:
    c:         { refreshModel: true, replace: true }
    p:         { refreshModel: true, replace: true }
    league_id: { refreshModel: true }
    season_id: { refreshModel: true }

  auth:   I()
  router: I()

  League:  (I 'models/league')
  Leagues: (I 'models/leagues')
  LSeasons:(I 'models/league-seasons')
  LSTeams: (I 'models/season/teams')
  Season:  (I 'models/season')
  User:    (I 'models/user')

  beforeModel: ->
    await @.auth.waypoint()
    return

  model: (params) ->
    { c, p, league_id, season_id } = params

    [ league, leagues, season, seasons, teams, user, ] = await (all [
      @.League.sync({ league_id })
      @.Leagues.sync()
      @.Season.sync({ season_id })
      @.LSeasons.sync({ league_id })
      @.LSTeams.sync({ c, p, season_id })
      @.User.sync()
    ])

    if !season.val.is_admin
      (@.router.transitionTo 'app.hello') 
      return

    return { league, leagues, teams, season, seasons, user, }

})
