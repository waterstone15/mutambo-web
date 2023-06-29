import capitalize from 'lodash/capitalize'
import get from 'lodash/get'
import Route from '@ember/routing/route'
import set from 'lodash/set'
import { all } from 'rsvp'
import { inject as I } from '@ember/service'

export default Route.extend({

  auth:   I('auth')
  router: I('router')

  Leagues: I('models/leagues')
  User:    I('models/user')

  beforeModel: ->
    await this.auth.waypoint()
    return

  model: ->
    [ user, leagues ] = await all([
      @User.sync()
      @Leagues.sync()
    ])

    gender = get(user, 'val.gender') ? ''
    set(user, 'ui.gender_display', capitalize(gender))

    return { user, leagues }

})
