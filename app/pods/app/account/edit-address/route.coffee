import get from 'lodash/get'
import Route from '@ember/routing/route'
import { all } from 'rsvp'
import { inject as I } from '@ember/service'

export default Route.extend({

  auth:   I()
  router: I()

  User:    (I 'models/user')
  Leagues: (I 'models/leagues')

  beforeModel: ->
    await @.auth.waypoint()
    return

  model: ->
    [ user, leagues ] = await (all [
      @.User.sync()
      @.Leagues.sync()
    ])
    return { user, leagues }

  setupController: (controller, model) ->
    (@._super controller, model)

    address = (get model, 'user.val.address')

    (controller.setProperties {
      msg:
        update_after:
          show: false
          days: 0
      form:
        errors: { address: [] }
        help: { address: false }
        ok: false
        submitted: false
        valid: { address: (@.User.ok.address address) }
        values: { address: address ? '' }
    })

})