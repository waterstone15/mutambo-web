import * as lz from 'lz-string'
import * as money from 'currency.js'
import get from 'lodash/get'
import isEmpty from 'lodash/isEmpty'
import map from 'lodash/map'
import merge from 'lodash/merge'
import Route from '@ember/routing/route'
import uppercase from 'lodash/uppercase'
import { all } from 'rsvp'
import { DateTime } from 'luxon'
import { inject as I } from '@ember/service'

export default (Route.extend {

  auth:   I()
  router: I()
  
  Leagues:       (I 'models/leagues')
  Registrations: (I 'models/registrations')
  User:          (I 'models/user')

  beforeModel: ->
    await @.auth.waypoint()
    return

  model: ->
    [ leagues, registrations, user, ] = await (all [
      @.Leagues.sync()
      @.Registrations.sync()
      @.User.sync()
    ])

    registrations.page.items = (map registrations.page.items, (_r) ->
      
      pmt = (get _r, 'val.payment')

      if !(isEmpty pmt)
        data = { code: pmt.val.code }
        data = JSON.stringify(data)
        data = lz.compressToEncodedURIComponent(data)

      return (merge _r, {
        ui:
          currency:   (uppercase ((get pmt, 'val.currency') || 'USD'))
          link:       if !(isEmpty pmt) then "#{window.location.origin}/pay##{data}"
          total:      (money ((get pmt, 'val.total') || 0), { pattern: '#' }).format()
          updated_at: DateTime.fromISO(_r.meta.updated_at).toFormat('yyyy.M.d')
      })
    )

    return { leagues, registrations, user, }

})
