import get from 'lodash/get'
import isString from 'lodash/isString'
import Route from '@ember/routing/route'
import { all } from 'rsvp'
import { inject as I } from '@ember/service'

export default (Route.extend {

  auth:    I()
  router:  I()

  User:    (I 'models/user')
  Leagues: (I 'models/leagues')


  beforeModel: ->
    await @.auth.waypoint()
    return


  model: ->
    [ user, leagues ] = await all([
      @.User.sync()
      @.Leagues.sync()
    ])
    return { user, leagues }


  setupController: (controller, model) ->
    (@._super controller, model)

    fn = (get model, 'user.val.full_name')

    (controller.setProperties {
      msg:
        update_after:
          show: false
          days: 0
      form:
        errors: { full_name: [] }
        help: { full_name: false }
        ok: false
        submitted: false
        valid: { full_name: (@.User.ok.fullName fn) }
        values: { full_name: fn ? '' }
    })

})