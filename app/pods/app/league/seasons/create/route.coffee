import EmberObject from '@ember/object'
import get from 'lodash/get'
import isEmpty from 'lodash/isEmpty'
import isString from 'lodash/isString'
import Route from '@ember/routing/route'
import { all } from 'rsvp'
import { inject as I } from '@ember/service'

export default Route.extend({

  auth:    I('auth')
  router:  I('router')

  League:  I('models/league')
  Leagues: I('models/leagues')
  User:    I('models/user')

  beforeModel: ->
    await this.auth.waypoint()
    return

  model: (params) ->
    { league_id } = params
    [ league, leagues, user, ] = await all([
      @League.sync({ league_id })
      @Leagues.sync()
      @User.sync()
    ])
    return { league, leagues, user, }

  setupController: (controller, model) ->
    this._super(controller, model)

    controller.setProperties({
      form:
        errors: { season_name: [] }
        help: { season_name: false }
        ok: false
        submitted: false
        valid: { season_name: false }
        values: { season_name: '' }
    })

})