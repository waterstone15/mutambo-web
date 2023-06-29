import * as lz from 'lz-string'
import * as money from 'currency.js'
import capitalize from 'lodash/capitalize'
import get from 'lodash/get'
import join from 'lodash/join'
import map from 'lodash/map'
import merge from 'lodash/merge'
import Route from '@ember/routing/route'
import uppercase from 'lodash/uppercase'
import { all } from 'rsvp'
import { DateTime } from 'luxon'
import { inject as I } from '@ember/service'

export default Route.extend({

  auth:    I()
  router:  I()
  
  Leagues:  (I 'models/leagues')
  Payments: (I 'models/payments')
  User:     (I 'models/user')

  beforeModel: ->
    await @.auth.waypoint()
    return

  model: ->
    [ user, payments, leagues ] = await (all [
      @.User.sync()
      @.Payments.sync()
      @.Leagues.sync()
    ])

    payments.page.items = (map payments.page.items, (_p) ->

      data = { code: _p.val.code }
      data = JSON.stringify(data)
      data = lz.compressToEncodedURIComponent(data)

      _p = (merge _p, {
        ui:
          created_at: DateTime.fromISO(_p.meta.created_at).toFormat('yyyy.M.d')
          currency:   (uppercase _p.val.currency)
          link:       "#{window.location.origin}/pay##{data}"
          total:      (money ((get _p, 'val.total') || 0), { pattern: '#' }).format()
      })
      return _p
    )

    return { user, payments, leagues }
})
