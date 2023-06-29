import Route from '@ember/routing/route'
import { all } from 'rsvp'
import { inject as I } from '@ember/service'

export default Route.extend({

  auth:   I('auth')
  router: I('router')

  League:      I('models/league')
  Leagues:     I('models/leagues')
  LSDivisions: I('models/league-season-divisions')
  LSeasons:    I('models/league-seasons')
  Season:      I('models/season')
  User:        I('models/user')


  beforeModel: ->
    await @.auth.waypoint()
    return


  model: (params) ->
    { league_id, season_id } = params

    [ league, leagues, divisions, seasons, season, user, ] = await all([
      @.League.sync({ league_id })
      @.Leagues.sync()
      @.LSDivisions.sync({ season_id })
      @.LSeasons.sync({ league_id })
      @.Season.sync({ season_id })
      @.User.sync()
    ])

    return { league, leagues, divisions, seasons, season, user }


  setupController: (controller, model) ->
    @._super(controller, model)


})
