import EmberObject from '@ember/object'
import get from 'lodash/get'
import isEmpty from 'lodash/isEmpty'
import isString from 'lodash/isString'
import Route from '@ember/routing/route'
import { all } from 'rsvp'
import { DateTime } from 'luxon'
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

    bd = get(model, 'user.val.birthday')
    birthday = {}
    if bd
      birthday =
        day: parseInt(DateTime.fromISO(bd).toFormat('d'))
        month: parseInt(DateTime.fromISO(bd).toFormat('M'))
        year: parseInt(DateTime.fromISO(bd).toFormat('yyyy'))

    controller.setProperties({
      msg:
        remaining:
          show: false
          count: 0
      form:
        errors: { birthday: [] }
        help: { birthday: false }
        ok: false
        submitted: false
        valid: { birthday: @User.ok.birthday(birthday) }
        values: { birthday: birthday }
    })

})