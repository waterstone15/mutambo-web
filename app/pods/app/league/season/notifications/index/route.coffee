import Route from '@ember/routing/route'
import { all } from 'rsvp'
import { inject as I } from '@ember/service'

export default Route.extend({

  auth:   I('auth')
  router: I('router')

  League:          I('models/league')
  Leagues:         I('models/leagues')
  LSNotifications: I('models/league-season-notifications')
  LSeasons:        I('models/league-seasons')
  Season:          I('models/season')
  User:            I('models/user')


  actions:
    reload: -> @.refresh()


  beforeModel: ->
    await @.auth.waypoint()
    return


  model: (params) ->
    { league_id, season_id } = params

    [ league, leagues, seasons, notifications, season, user, ] = await all([
      @.League.sync({ league_id })
      @.Leagues.sync()
      @.LSeasons.sync({ league_id })
      @.LSNotifications.sync({ season_id })
      @.Season.sync({ season_id })
      @.User.sync()
    ])

    return { league, leagues, seasons, notifications, season, user, }


  setupController: (controller, model) ->
    @._super(controller, model)


})
