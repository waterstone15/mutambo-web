import EmberObject from '@ember/object'
import get from 'lodash/get'
import isEmpty from 'lodash/isEmpty'
import isString from 'lodash/isString'
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

    dn = get(model, 'user.val.display_name')

    controller.setProperties({
      form:
        errors: { display_name: [] }
        help: { display_name: false }
        ok: false
        submitted: false
        valid: { display_name: @User.ok.displayName(dn) }
        values: { display_name: dn ? '' }
    })

})