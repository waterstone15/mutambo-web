import * as currency from 'currency.js'
import cloneDeep from 'lodash/cloneDeep'
import get from 'lodash/get'
import keys from 'lodash/keys'
import Route from '@ember/routing/route'
import set from 'lodash/set'
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

    ps = get(season_settings, 'val.prices')
    for price in keys(ps)
      for category in keys(ps[price])
        fmt = currency(ps[price][category]).format({ symbol: '', separator: '', decimal: ".", precision: 2  })
        set(season_settings, "ui.prices.#{price}.#{category}", "#{fmt}")

    return { league, leagues, seasons, season, season_settings, user, }


  setupController: (controller, model) ->
    @._super(controller, model)

    prices = cloneDeep(get(model, 'season_settings.ui.prices'))

    controller.setProperties({
      form:
        errors: { prices: [] }
        help: { prices: true }
        ok: false
        submitted: false
        valid: { prices: true }
        values: { prices: prices ? {} }
    })


})

