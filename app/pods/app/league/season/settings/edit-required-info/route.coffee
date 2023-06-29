import get from 'lodash/get'
import cloneDeep from 'lodash/cloneDeep'
import Route from '@ember/routing/route'
import { all } from 'rsvp'
import { inject as I } from '@ember/service'

export default Route.extend({

  auth:   I('auth')
  router: I('router')

  League:         I('models/league')
  Leagues:        I('models/leagues')
  LSeasons:       I('models/league-seasons')
  Season:         I('models/season')
  SeasonSettings: I('models/season-settings')
  User:           I('models/user')

  beforeModel: ->
    await @.auth.waypoint()
    return

  model: (params) ->
    { league_id, season_id } = params
    [ league, leagues, seasons, season, season_settings, user, ] = await all([
      @.League.sync({ league_id })
      @.Leagues.sync()
      @.LSeasons.sync({ league_id })
      @.Season.sync({ season_id })
      @.SeasonSettings.sync({ season_id })
      @.User.sync()
    ])

    return { league, leagues, seasons, season, season_settings, user, }

  setupController: (controller, model) ->
    @._super(controller, model)

    info = cloneDeep(get(model, 'season_settings.val.required_info'))

    controller.setProperties({
      form:
        errors: { info: [] }
        help: { info: true }
        ok: false
        submitted: false
        valid: { info: true }
        values: { info: info ? {} }
    })

})

