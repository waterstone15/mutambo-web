import * as qs from 'query-string'
import EmberObject from '@ember/object'
import env from 'mutambo-web/config/environment'
import map from 'lodash/map'
import merge from 'lodash/merge'
import reverse from 'lodash/reverse'
import Service, { inject } from '@ember/service'
import sortBy from 'lodash/sortBy'
import throttle from 'lodash/throttle'
import { A } from '@ember/array'
import { all } from 'rsvp'
import { DateTime } from 'luxon'
import { set, setProperties, get } from '@ember/object'

export default Service.extend({

  auth: inject('auth')
  fb: inject('fb-init')

  init: ->
    this._super(...arguments)
    this._debounce_load()
    return

  _debounce_load: ->
    func      = this._load.bind(this)
    wait      = 1000
    options   = { leading: true, trailing: false }
    this.load = throttle(func, wait, options)

  _load: ({ season_id }) ->
    [ fb, uid ] = await all([ this.fb.get(), this.auth.getUid() ])

    token   = await fb.auth().currentUser.getIdToken()
    headers = { 'Content-Type': 'application/json', 'firebase-auth-token': token }
    try
      query = qs.stringify({ season_id })
      res = await fetch("#{env.app.apiUrl}/v1/league/season/registrations?#{query}", { headers })
      data = await res.json()

      { registrations } = data

      registrations = reverse(sortBy(registrations, ['meta.created_at']))
      registrations = map(registrations, (_r)->
        return merge(_r, {
          val:
            date_formatted: DateTime.fromISO(_r.meta.created_at).toFormat('MMMM dd, yyyy')
            time_formatted: DateTime.fromISO(_r.meta.created_at).toFormat('h:mm a ZZZZ')
        })
      )
    catch e
      console.log e
    return registrations

  sync: (opts) ->
    { force, season_id } = (opts ? {})
    this._debounce_load() if force
    return await this.load({ season_id })

})