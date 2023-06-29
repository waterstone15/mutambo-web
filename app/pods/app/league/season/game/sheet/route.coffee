import get from 'lodash/get'
import Route from '@ember/routing/route'
import toInteger from 'lodash/toInteger'
import { all } from 'rsvp'
import { DateTime } from 'luxon'
import { inject as I } from '@ember/service'

export default Route.extend({

  queryParams:
    game_id:   { refreshModel: true }
    league_id: { refreshModel: true }
    season_id: { refreshModel: true }

  auth:   I()
  router: I()

  League:   (I 'models/league')
  Leagues:  (I 'models/leagues')
  LSeasons: (I 'models/league-seasons')
  LSGame:   (I 'models/season/game')
  Season:   (I 'models/season')
  Sheet:    (I 'models/season/game/sheet')
  User:     (I 'models/user')


  beforeModel: ->
    await @.auth.waypoint()
    return

  model: (params) ->
    { game_id, league_id, season_id } = params

    [ game, league, leagues, seasons, season, sheet, user, ] = await (all [
      @.LSGame   .sync({ game_id, season_id })
      @.League   .sync({ league_id })
      @.Leagues  .sync()
      @.LSeasons .sync({ league_id })
      @.Season   .sync({ season_id })
      @.Sheet    .sync({ game_id, league_id, season_id })
      @.User     .sync()
    ])

    return { game, league, leagues, seasons, season, sheet, user, }


})

