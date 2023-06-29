import Route from '@ember/routing/route'
import { all } from 'rsvp'
import { inject as I } from '@ember/service'

export default Route.extend({

  queryParams:
    end_at:        { refreshModel: true, replace: true }
    end_before:    { refreshModel: true, replace: true }
    filters:       { refreshModel: true, replace: true }
    league_id:     { refreshModel: true, replace: true }
    limit:         { refreshModel: true, replace: true }
    limit_to_last: { refreshModel: true, replace: true }
    order_by:      { refreshModel: true, replace: true }
    search_at:     { refreshModel: true, replace: true }
    season_id:     { refreshModel: true, replace: true }
    start_after:   { refreshModel: true, replace: true }
    start_at:      { refreshModel: true, replace: true }

  auth:I('auth')

  Schedule: I('models/schedule')

  model: (params) ->
    { end_before, league_id, search_at, season_id, start_after, } = params

    [ isLoggedIn, schedule ] = await all([
      @auth.isLoggedIn()
      @Schedule.sync({ end_before, league_id, search_at, season_id, start_after, })
    ])

    return { schedule, isLoggedIn }

})
