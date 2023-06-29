import capitalize from 'lodash/capitalize'
import compact from 'lodash/compact'
import get from 'lodash/get'
import Route from '@ember/routing/route'
import set from 'lodash/set'
import split from 'lodash/split'
import { all } from 'rsvp'
import { DateTime } from 'luxon'
import { inject as I } from '@ember/service'

export default (Route.extend {

  auth:   I()
  router: I()

  Leagues: (I 'models/leagues')
  User:    (I 'models/user')

  beforeModel: ->
    await @.auth.waypoint()
    return

  model: ->
    [ leagues, user ] = await (all [
      @.Leagues.sync()
      @.User.sync()
    ])

    gender = (get user, 'val.gender')
    (set user, 'ui.gender', (capitalize gender))

    bday = (get user, 'val.birthday')
    (set user, 'ui.birthday', (if !!bday then DateTime.fromISO(bday, { zone: 'utc' }).toFormat('DDD')))

    address = (compact (split (get user, 'val.address'), '\n'))
    (set user, 'ui.address', address)

    return { user, leagues }

})
