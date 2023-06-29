import Route from '@ember/routing/route'
import { all } from 'rsvp'
import { inject as I } from '@ember/service'

export default Route.extend({

  auth:   I('auth')
  router: I('router')

  League:        I('models/league')
  Leagues:       I('models/leagues')
  LSFacilities:  I('models/league-season-facilities')
  LSeasons:      I('models/league-seasons')
  Season:        I('models/season')
  User:          I('models/user')


  beforeModel: ->
    await @.auth.waypoint()
    return


  model: (params) ->
    { league_id, season_id } = params

    [ league, leagues, seasons, facilities, season, user, ] = await all([
      @.League.sync({ league_id })
      @.Leagues.sync()
      @.LSeasons.sync({ league_id })
      @.LSFacilities.sync({ season_id })
      @.Season.sync({ season_id })
      @.User.sync()
    ])

    return { league, leagues, seasons, facilities, season, user, }


})
