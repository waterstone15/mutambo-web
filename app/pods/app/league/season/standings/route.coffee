import Route from '@ember/routing/route'
import { all } from 'rsvp'
import { inject as I} from '@ember/service'

export default (Route.extend {

  queryParams:
    league_id: { refreshModel: true }
    season_id: { refreshModel: true }

  auth:   I()
  router: I()

  League:      I('models/league')
  Leagues:     I('models/leagues')
  LSeasons:    I('models/league-seasons')
  LSStandings: I('models/season/standings')
  Season:      I('models/season')
  User:        I('models/user')


  beforeModel: ->
    await @.auth.waypoint()
    return


  model: (params) ->
    { league_id, season_id } = params

    [ league, leagues, seasons, season, standings, user, ] = await all([
      @.League      .sync({ league_id })
      @.Leagues     .sync()
      @.LSeasons    .sync({ league_id })
      @.Season      .sync({ season_id })
      @.LSStandings .sync({ season_id })
      @.User        .sync()
    ])

    return { league, leagues, seasons, season, standings,  user, }


})
