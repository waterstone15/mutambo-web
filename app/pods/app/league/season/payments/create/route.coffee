import Route from '@ember/routing/route'
import { all } from 'rsvp'
import { inject as I } from '@ember/service'

export default (Route.extend {

  queryParams:
    league_id: { refreshModel: true, replace: true }
    season_id: { refreshModel: true, replace: true }

  auth:   I()
  router: I()

  League:   I('models/league')
  Leagues:  I('models/leagues')
  LSeasons: I('models/league-seasons')
  Season:   I('models/season')
  User:     I('models/user')

  beforeModel: ->
    await @.auth.waypoint()
    return

  model: (params) ->
    { league_id, season_id, } = params

    [ league, leagues, seasons, season, user, ] = await (all [
      @.League   .sync({ league_id })
      @.Leagues  .sync()
      @.LSeasons .sync({ league_id })
      @.Season   .sync({ season_id })
      @.User     .sync()
    ])

    return { league, leagues, seasons, season, user, }


  setupController: (controller, model) ->
    (@._super controller, model)

    (controller.setProperties {
      form:
        ok: false
        submitted: false
        errors:
          currency: []
          description: []
          price: []
          title: []
        help:
          currency: false
          description: false
          price: false
          title: false
        valid:
          currency: true
          description: false
          price: true
          title: false
        values:
          currency: 'usd'
          description: "Payment to #{model.league.val.name}, #{model.season.val.name} for ..."
          price: '10.00'
          title: 'Payment'
    })

})
