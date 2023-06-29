import * as qs from 'query-string'
import EmberObject from '@ember/object'
import env from 'mutambo-web/config/environment'
import map from 'lodash/map'
import merge from 'lodash/merge'
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
    wait      = 1000 * 60
    options   = { leading: true, trailing: false }
    this.load = throttle(func, wait, options)

  _load: ({ league_id }) ->
    [ fb, uid ] = await all([ this.fb.get(), this.auth.getUid() ])

    token   = await fb.auth().currentUser.getIdToken()
    headers = { 'Content-Type': 'application/json', 'firebase-auth-token': token }
    try
      query = qs.stringify({ league_id })
      res = await fetch("#{env.app.apiUrl}/v1/league/free-agent-cards?#{query}", { headers })
      data = await res.json()

      { free_agent_cards } = data
    catch e
      console.log e
    return free_agent_cards

  sync: (opts) ->
    { force, league_id } = (opts ? {})
    this._debounce_load() if force
    return await this.load({ league_id })

})