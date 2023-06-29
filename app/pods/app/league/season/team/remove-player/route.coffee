import get from 'lodash/get'
import Route from '@ember/routing/route'
import toInteger from 'lodash/toInteger'
import { all } from 'rsvp'
import { DateTime } from 'luxon'
import { inject as I } from '@ember/service'

export default Route.extend({

  queryParams:
    league_id: { refreshModel: true }
    player_id: { refreshModel: true }
    season_id: { refreshModel: true }
    team_id:   { refreshModel: true }

  auth:   I()
  router: I()

  League:    (I 'models/league')
  Leagues:   (I 'models/leagues')
  LSeasons:  (I 'models/league-seasons')
  LSTeam:    (I 'models/season/team')
  LSTPlayer: (I 'models/season/team/player')
  Season:    (I 'models/season')
  User:      (I 'models/user')

  beforeModel: ->
    await @.auth.waypoint()
    return

  model: (params) ->
    { league_id, player_id, season_id, team_id } = params

    console.log { league_id, player_id, season_id, team_id }

    [ league, leagues, player, seasons, season, team, user, ] = await (all [
      @.League    .sync({ league_id })
      @.Leagues   .sync()
      @.LSTPlayer .sync({ player_id, season_id, team_id, })
      @.LSeasons  .sync({ league_id })
      @.Season    .sync({ season_id })
      @.LSTeam    .sync({ team_id, season_id })
      @.User      .sync()
    ])

    return { league, leagues, player, seasons, season, team, user, }


  setupController: (controller, model) ->
    (@._super controller, model)

    (controller.setProperties {
      form:
        errors:
          confirm_text: []
        help:
          confirm_text: false
        ok: false
        submitted: false
        valid:
          confirm_text: false
        values:
          confirm_text: ''
        warnings:
          confirm_text: true
    })

})

