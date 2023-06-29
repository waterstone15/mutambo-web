import get from 'lodash/get'
import Route from '@ember/routing/route'
import { all } from 'rsvp'
import { inject as I } from '@ember/service'

export default (Route.extend {

  queryParams:
    misconduct_id: { refreshModel: true }
    league_id:     { refreshModel: true }
    season_id:     { refreshModel: true }

  auth:   I()
  router: I()

  League:       (I 'models/league')
  Leagues:      (I 'models/leagues')
  LSeasons:     (I 'models/league-seasons')
  LSMisconduct: (I 'models/season/misconduct')
  Season:       (I 'models/season')
  User:         (I 'models/user')

  beforeModel: ->
    await @.auth.waypoint()
    return

  model: (params) ->
    { misconduct_id, league_id, season_id } = params

    [ league, leagues, misconduct, seasons, season,  user, ] = await (all [
      @.League       .sync({ league_id })
      @.Leagues      .sync()
      @.LSMisconduct .sync({ misconduct_id, season_id })
      @.LSeasons     .sync({ league_id })
      @.Season       .sync({ season_id })
      @.User         .sync()
    ])

    return { league, leagues, misconduct, seasons, season, user, }


  setupController: (controller, model) ->
    (@._super controller, model)

    _m = model.misconduct ? null

    (controller.setProperties {
      form:
        errors:
          status: []
        help:
          status: false
        ok: false
        submitted:  false
        valid:
          status: true
        values:
          status: (get _m, 'val.status') ? null
        warnings: {}
    })

})

