import Route from '@ember/routing/route'
import { all } from 'rsvp'
import { inject as I } from '@ember/service'

export default (Route.extend {

  queryParams:
    league_id: { refreshModel: true }
    season_id: { refreshModel: true }
    team_id:   { refreshModel: true }

  auth:   I()
  router: I()

  League:  (I 'models/league')
  Leagues: (I 'models/leagues')
  LSeasons:(I 'models/league-seasons')
  LSTeam:  (I 'models/season/team')
  Season:  (I 'models/season')
  User:    (I 'models/user')

  beforeModel: ->
    await @.auth.waypoint()
    return

  model: (params) ->
    { league_id, season_id, team_id } = params

    [ league, leagues, season, seasons, team, user, ] = await (all [
      @.League.sync({ league_id })
      @.Leagues.sync()
      @.Season.sync({ season_id })
      @.LSeasons.sync({ league_id })
      @.LSTeam.sync({ season_id, team_id })
      @.User.sync()
    ])

    if !season.val.is_admin
      (@.router.transitionTo 'app.hello') 
      return

    return { league, leagues, season, seasons, team, user, }

})
