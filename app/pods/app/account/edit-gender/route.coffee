import capitalize from 'lodash/capitalize'
import EmberObject from '@ember/object'
import get from 'lodash/get'
import Route from '@ember/routing/route'
import { all } from 'rsvp'
import { inject } from '@ember/service'

export default Route.extend({

  auth: inject('auth')
  router: inject('router')
  User: inject('models/user')
  Leagues: inject('models/leagues')

  beforeModel: ->
    await this.auth.waypoint()
    return

  model: ->
    [ user, leagues ] = await all([
      @User.sync()
      @Leagues.sync()
    ])
    return { user, leagues }

  setupController: (controller, model) ->
    this._super(controller, model)

    gender = get(model, 'user.val.gender')

    controller.setProperties({
      form:
        errors: { gender: [] }
        help: { gender: false }
        ok: true
        submitted: false
        valid: { gender: true }
        values: {
          gender: gender ? ''
        }
    })

})